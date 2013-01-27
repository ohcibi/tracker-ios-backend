require 'spec_helper'

shared_examples_for "accessed from anonymous users" do
  it "should denial access" do
    expect(JSON.parse(response.body)["success"]).to be_false
    response.response_code.should == 401
  end
end

describe Api::TracksController do
  context "with anonymous user" do
    describe "create track" do
      before { post :create, format: :json }
      it_should_behave_like "accessed from anonymous users"
    end
    describe "delete track" do
      let(:user) { FactoryGirl.create :user }
      let(:track) do
        tracks = user.tracks << FactoryGirl.create(:track)
        tracks.first
      end
      before { delete :destroy, format: :json, id: track }
      it_should_behave_like "accessed from anonymous users"
    end

    describe "PUT 'finish'" do
      let(:track) { FactoryGirl.create :track }
      before { put :finish, format: :json, id: track }
      it_should_behave_like "accessed from anonymous users"
    end
  end

  context "with signed in user" do
    let(:user) { FactoryGirl.create :user }
    let(:auth_token) { user.authentication_token }
    describe "create track" do
      it "should be successful" do
        expect do
          post :create, format: :json, auth_token: auth_token
          JSON.parse(response.body)["success"].should == true
          JSON.parse(response.body)["track_id"].should be_an Integer
        end.to change(Track, :count).by 1
      end
    end

    describe "delete track" do
      let!(:track) do
        tracks = user.tracks << FactoryGirl.create(:track)
        tracks.first
      end

      it "should be successful" do
        expect do
          delete :destroy, format: :json, id: track, auth_token: auth_token
          expect(Track.find_by_id track.id).to be_nil
        end.to change(Track, :count).by -1
      end

      context "as wrong user" do
        let(:other_user) { FactoryGirl.create :user }

        before { delete :destroy, format: :json, id: track, auth_token: other_user.authentication_token }
        it_should_behave_like "accessed from anonymous users"
      end
    end

    describe "PUT 'finish'" do
      let(:track) { FactoryGirl.create :track, user: user }

      it "sets the finish attribute of the track to true" do
        expect do
          put :finish, format: :json, id: track, auth_token: user.authentication_token
          track.reload
        end.to change(track, :finished).from(false).to(true)
      end

      context "as wrong user" do
        let(:other_user) { FactoryGirl.create :user }

        before { put :finish, format: :json, id: track, auth_token: other_user.authentication_token }
        it_should_behave_like "accessed from anonymous users"
      end
    end
  end

  describe "GET 'index'" do
    let(:user) { FactoryGirl.create :user }

    it "should return all the tracks of the user" do
      5.times { user.tracks << FactoryGirl.create(:track) }
      get :index, user_id: user.id, format: :json
      expect(response.body).to eql user.tracks.to_json only: [:id, :finished, :created_at]
    end
  end
end
