require 'spec_helper'

feature "Tracks", %q{
  In Order to have a tracks db
  I need to create tracks
  And add coordinates to them
} do

  background do
    @user = FactoryGirl.create :user
  end

  scenario "Create Track" do
    expect do
      page.driver.post api_tracks_path, auth_token: @user.authentication_token
    end.to change(Track, :count).by 1
  end
end
