require 'spec_helper'

Time.zone = 'Berlin'

describe User do
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :md5email }
  it { should respond_to :last_seen }
  it { should respond_to :buddies }

  describe "md5email" do
    it "returns the md5 hash of the users email address" do
      email = "test@test.de"
      user = User.new email: email
      expect(user.md5email).to eql Digest::MD5.hexdigest(email)
    end
  end

  describe "online?" do
    it "returns true for a user that was the last time seen less than 5 min ago" do
      user = FactoryGirl.create :user, last_seen: Time.zone.now
      expect(user.online?).to be_true
      user = FactoryGirl.create :user, last_seen: 1.minute.ago
      expect(user.online?).to be_true
      user = FactoryGirl.create :user, last_seen: 2.minute.ago
      expect(user.online?).to be_true
      user = FactoryGirl.create :user, last_seen: 3.minute.ago
      expect(user.online?).to be_true
      user = FactoryGirl.create :user, last_seen: 4.minute.ago
      expect(user.online?).to be_true
    end
    it "returns false for a user whos last seen is more than 5 min ago" do
      user = FactoryGirl.create :user, last_seen: 6.minute.ago
      expect(user.online?).to be_false
    end
  end

  describe "order" do
    it "is ordered by last_seen" do
      users = [FactoryGirl.create(:user, last_seen: 1.hour.ago), FactoryGirl.create(:user, last_seen: 1.minute.ago)]
      expect(User.all).to eql users.reverse
    end
  end

  describe "buddy relationship" do
    it "has no buddies by default" do
      expect(subject.buddies.count).to eql 0
    end

    it "associates buddies" do
      user = FactoryGirl.create :user
      buddy = FactoryGirl.create :user
      user.buddies << buddy
      expect(user.buddies.count).to eql 1
      expect(user.buddies.first).to eql buddy
    end
  end
end
