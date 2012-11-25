require 'spec_helper'

shared_examples_for "accessed from anonymous users" do
  it "should denial access" do
    JSON.parse(response.body).should == {"success" => false, "message" => "Not signed in"}
    response.response_code.should == 401
  end
end

describe Api::TracksController do
  context "with anonymous user" do
    describe "create track" do
      before { post :create, format: :json }
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
  end
end
