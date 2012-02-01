# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "largest average word length rule" do
  it "should return chunks with the maximum average word length" do
    chunks = [
              gen_words(["国际化"]),
              gen_words(["国际", "化"]),
              gen_words(["国", "际", "化"])
             ]
    chunks = RMMSeg::LAWLRule.filter(chunks)
    chunks.length.should == 1
    chunks[0][0].text.should == "国际化"
  end
end
