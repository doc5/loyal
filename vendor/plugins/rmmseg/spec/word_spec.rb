# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'word' do
  it "should return proper length on CJK words" do
    w = RMMSeg::Word.new('中文')
    w.length.should == 2
  end
end
