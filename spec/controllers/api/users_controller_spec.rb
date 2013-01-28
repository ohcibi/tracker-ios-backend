require 'spec_helper'

describe Api::UsersController do
  let!(:users) do
    users = []
    5.times do
      user = FactoryGirl.create :user
      users << user
    end
    users[0].tracks << FactoryGirl.create(:track)
    users[0].tracks << FactoryGirl.create(:track)
    users[0].tracks << FactoryGirl.create(:track)

    users[1].tracks << FactoryGirl.create(:track)
    users[1].tracks << FactoryGirl.create(:track)

    users[2].tracks << FactoryGirl.create(:track)
    users[2].tracks << FactoryGirl.create(:track)
    users[2].tracks << FactoryGirl.create(:track)
    users[2].tracks << FactoryGirl.create(:track)

    users[3].tracks << FactoryGirl.create(:track)

    users[4].tracks << FactoryGirl.create(:track)
    users[4].tracks << FactoryGirl.create(:track)
    users[4].tracks << FactoryGirl.create(:track)
    users[4].tracks << FactoryGirl.create(:track)
    users[4].tracks << FactoryGirl.create(:track)
    users
  end

  describe "GET 'index'" do
    it "returns a list of all users along with the number of their tracks" do
      get :index, format: :json
      expect(response.body).to eql users.to_json only: [:id, :name, :last_seen], methods: [:md5email, :tracks_count, :online?]
    end
  end
end
