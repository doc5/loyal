# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "smallest variance of word length rule" do
  it "should return chunks with the smallest word length variance" do
    chunks = [
              gen_words(["研究", "生命", "起源"]),
              gen_words(["研究生", "命", "起源"])
             ]
    chunks = RMMSeg::SVWLRule.filter(chunks)
    chunks.length.should == 1
    chunks[0][0].text.should == "研究"
  end
end
