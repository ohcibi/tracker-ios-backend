require 'spec_helper'

describe Track do
  it { should respond_to :finished }
  it { should_not be_finished }
  it "should delete dependent coordinates when it is deleted" do
    track = FactoryGirl.create :track
    track.coordinates << FactoryGirl.create(:coordinate)
    track.destroy
    expect(Coordinate.count).to eql 0
  end
end
