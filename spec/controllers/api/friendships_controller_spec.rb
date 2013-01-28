require 'spec_helper'

describe Api::FriendshipsController do
  let(:user) { FactoryGirl.create :user }
  let(:buddy) { FactoryGirl.create :user }

  describe "GET 'index'" do
    before { user.buddies << buddy }
    context "without user_id" do
      context "as anonymous user" do
        before { get :index, format: :json }
        it_should_behave_like "accessed from anonymous users"
      end

      context "as logged in user" do
        it "returns a list of the current users buddies" do
          get :index, format: :json, auth_token: user.authentication_token
          expect(response.body).to eql user.friendships.to_json only: [:id], include: {buddy: {only: [:id, :name, :last_seen], methods: [:md5email, :tracks_count, :online?] } }
        end
      end
    end
  end

  describe "POST 'create'" do
    context "as anonymous user" do
      before { post :create, format: :json, buddy_id: buddy.id }
      it_should_behave_like "accessed from anonymous users"
    end

    context "as logged in user" do
      it "adds the buddy to the users buddies" do
        expect do
          post :create, format: :json, buddy_id: buddy.id, auth_token: user.authentication_token
          user.reload
        end.to change(user.buddies, :count).by 1
      end
    end
  end

  describe "DELETE 'destroy'" do
    before { user.buddies << buddy }
    context "as anonymous user" do
      before { delete :destroy, format: :json, id: user.friendships.first }
    end

    context "as logged in user" do
      it "removes the buddy from the users buddies" do
        expect do
          delete :destroy, format: :json, id: user.friendships.first, auth_token: user.authentication_token
          user.reload
        end.to change(user.buddies, :count).by -1
      end
    end
  end
end
