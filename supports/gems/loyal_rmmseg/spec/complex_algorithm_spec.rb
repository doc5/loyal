# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "complex algorithm" do
  it "should behave well as svwl rule" do
    text = "研究生命科学"
    segs = RMMSeg::ComplexAlgorithm.new(text).segment
    segs.length.should == 3
    segs[0].should == "研究"
  end

  it "should segment a relative big chunk of Chinese" do
    text = "主持人把一只割去头的羊放在指定处。枪响后，甲乙两队共同向羊飞驰而去，先抢到羊的同队队员互相掩护，极力向终点奔驰，双方骑手们施展各种技巧，围追堵截，拼命抢夺。叼着羊先到达终点的为胜方。获胜者按照当地的习俗，将羊当场烤熟，请众骑手共享，称为“幸福肉”。"
    segs = RMMSeg::ComplexAlgorithm.new(text).segment
    segs.length.should == 87
    segs[0].should == "主持人"
  end
end
