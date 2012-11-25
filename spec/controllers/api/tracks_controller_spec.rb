require 'spec_helper'

describe Api::TracksController do
  describe "create Track" do
    context "as non signed in user" do
      it "should do something" do
        get :create, format: :json
        JSON.parse(response.body).should == {"success" => false, "message" => "Not signed in"}
        response.response_code.should == 401
      end
    end
  end
end
