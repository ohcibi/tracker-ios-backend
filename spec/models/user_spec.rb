require 'spec_helper'

describe User do
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :md5email }
  describe "md5email" do
    it "returns the md5 hash of the users email address" do
      email = "test@test.de"
      user = User.new email: email
      expect(user.md5email).to eql Digest::MD5.hexdigest(email)
    end
  end
end
