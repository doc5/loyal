# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'maximum matching rule' do
  it "should select chunks with the maximun total length" do
    chunks = [
              gen_words(["眼看", "就要", "来了"]),
              gen_words(["眼", "看", "就", "要", "来", "了"]),
              gen_words(["眼看", "就要", "来"]),
              gen_words(["眼", "看", "就"])
             ]
    chunks = RMMSeg::MMRule.filter(chunks)
    chunks.length.should == 2
  end
end
