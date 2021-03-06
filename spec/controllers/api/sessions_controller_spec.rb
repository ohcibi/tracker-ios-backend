require 'spec_helper'

describe Api::SessionsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }
  describe "create session" do
    let!(:user) { FactoryGirl.create :user }
    context "with invalid email" do
      before { post :create }
      it "should be not successful" do
        response.should_not be_success
        JSON.parse(response.body)["success"].should be_false
        JSON.parse(response.body)["message"].should == "Falsche E-Mail Adresse"
      end
    end

    context "with invalid password" do
      before { post :create, email: user.email }
      it "should be not successful" do
        response.should_not be_success
        JSON.parse(response.body)["success"].should be_false
        JSON.parse(response.body)["message"].should == "Falsches Passwort"
      end
    end

    context "with valid credentials" do
      before { post :create, email: user.email, password: "password" }
      it "should be successful" do
        response.should be_success
        JSON.parse(response.body)["success"].should be_true
        expect(JSON.parse(response.body)["user"]).to eql user.to_json only: [:id, :name, :email, :authentication_token], methods: [:md5email]
      end
    end
  end
end
