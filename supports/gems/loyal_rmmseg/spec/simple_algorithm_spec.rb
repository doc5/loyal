# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "simple algorithm" do
  it "should handle simple cases" do
    text = "我们都喜欢用 Ruby"
    segs = RMMSeg::SimpleAlgorithm.new(text).segment
    segs.length.should == 5
    segs[0].should == "我们"
  end

  it "shouldn't be able to handle some case" do
    text = "研究生命起源"
    segs = RMMSeg::SimpleAlgorithm.new(text).segment
    segs.length.should == 3
    segs[0].should_not == "研究"
    segs[0].should == "研究生"
  end

  it "should handle pure English as well" do
    text = "This is a paragraph of English."
    segs = RMMSeg::SimpleAlgorithm.new(text).segment
    segs.length.should == 6
    segs[0].should == "This"
  end

  it "should handle byte positions of English well" do
    text = "This is a paragraph of English."
    algor = RMMSeg::SimpleAlgorithm.new(text)
    3.times { algor.next_token }
    token = algor.next_token
    token.text.should == "paragraph"
    token.start.should == 10
    token.end.should == 19
  end

  it "should handle byte positions of Chinese well" do
    text = "这是一句中文"
    algor = RMMSeg::SimpleAlgorithm.new(text)
    2.times { algor.next_token }
    token = algor.next_token
    token.text.should == "中文"
    token.start.should == 12
    token.end.should == 18
  end
end
