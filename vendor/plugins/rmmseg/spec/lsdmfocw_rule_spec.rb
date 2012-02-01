# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "largest sum of degree of morphemic freedom of one-character words rule" do
  it "should return chunks of the largest sum of degree of morphemic freedom of one-character words" do
    chunks = [
              gen_words(["主要", "是", "因为"], [nil, 100, nil]),
              gen_words(["主", "要是", "因为"], [10, nil, nil])
             ]
    chunks = RMMSeg::LSDMFOCWRule.filter(chunks)
    chunks.length.should == 1
    chunks[0][0].text.should == "主要"
  end
end
