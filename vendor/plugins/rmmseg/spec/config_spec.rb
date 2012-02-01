require File.join(File.dirname(__FILE__), 'spec_helper')

describe "RMMSeg Config" do
  it "should be able to store and retrive config values" do
    RMMSeg::Config.algorithm = :simple
    RMMSeg::Config.algorithm.should == :simple
  end

  it "should reject invalid algorithm" do
    lambda { RMMSeg::Config.algorithm = :foobar }.should raise_error(ArgumentError)
  end
end
