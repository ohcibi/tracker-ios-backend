require 'spec_helper'

describe Coordinate do
  describe "coordinates" do
    it "consist of both latitude and longitude which are floating point" do
      Coordinate.new(lat: 6.25, lng: 52.5).should be_valid
      Coordinate.new(lat: "6.25", lng: "52.5").should be_valid
      Coordinate.new.should_not be_valid
      Coordinate.new(lat: "bla", lng: "blub").should_not be_valid
      Coordinate.new(lng: 52.5).should_not be_valid
    end
  end
end
