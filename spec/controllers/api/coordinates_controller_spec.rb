require 'spec_helper'

describe Api::CoordinatesController do
  let(:user) { FactoryGirl.create :user }
  let(:track) { FactoryGirl.create :track, user: user }
  describe "create coordinates" do
    it "should respond with 404 without a proper track_id" do
      post :create, track_id: "bogus", auth_token: user.authentication_token
      response.should_not be_success
      response.response_code.should == 404
      JSON.parse(response.body)["success"].should be_false
      JSON.parse(response.body)["message"].should == "Wrong track_id"
    end

    it "should respond with 400 without proper coordinates" do
      post :create, track_id: track.id, auth_token: user.authentication_token
      response.should_not be_success
      response.response_code.should == 400
      JSON.parse(response.body)["success"].should be_false
      JSON.parse(response.body)["message"].should == "Invalid coordinates"
    end

    it "should create coordinates for the track" do
      coordinates = { lat: 62.5, lng: 6.2 }
      expect do
        post :create, track_id: track.id, auth_token: user.authentication_token, coordinates: coordinates
        response.should be_success
        JSON.parse(response.body)["success"].should be_true
        JSON.parse(response.body)["message"].should == "success"
      end.to change(track.coordinates, :count).by 1
    end
  end

  describe "GET 'index'" do
    it "should return all coordinates for a track" do
      10.times { track.coordinates << FactoryGirl.create(:coordinate) }
      get :index, track_id: track.id, format: :json
      expect(response.body).to eql track.coordinates.to_json only: [:id, :lat, :lng]
    end
  end
end
