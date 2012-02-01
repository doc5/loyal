# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'chunk' do
  before(:all) do
    @words = gen_words(['中文', '中国字', '我', '中华人民共和国'],
                       [10, 7, 100, 8])
  end

  it "should return proper total length" do
    RMMSeg::Chunk::total_length(@words).should == 13
  end

  it "should return proper average length" do
    RMMSeg::Chunk::average_length(@words).should == 13.0/4
  end

  it "should return proper variance" do
    RMMSeg::Chunk::variance(@words).to_i.should == 4
  end

  it "should return proper degree of morphemic freedom" do
    RMMSeg::Chunk::degree_of_morphemic_freedom(@words).should == 100
  end
end
