require File.join(File.dirname(__FILE__), 'spec_helper')

describe "dictionary" do

  before(:all) do
    @dic = RMMSeg::Dictionary.instance
  end

  it "should contain frequency information for chars" do
    @dic.get_word("你").frequency.should == 915385
  end

  it "should handle words" do
    @dic.has_word?("你们").should == true
  end

  it "should ignore words which exceed the maximum length" do
    @dic.has_word?("这是一个超出长度的词组").should == false
  end
end
