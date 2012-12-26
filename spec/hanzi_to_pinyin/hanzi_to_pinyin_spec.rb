# encoding:utf-8
require "spec_helper"

describe HanziToPinyin do
  it "hanzi_2_pinyin method" do
    HanziToPinyin.hanzi_2_pinyin("我们").should == "wm"
    HanziToPinyin.hanzi_2_pinyin("北京东方网力科技股份有限公司").should == "bjdfwlkjgfyxgs"
    HanziToPinyin.hanzi_2_pinyin("_").should == "_"
    HanziToPinyin.hanzi_2_pinyin("1").should == "1"
    HanziToPinyin.hanzi_2_pinyin("a").should == "a"
    HanziToPinyin.hanzi_2_pinyin("A").should == "a" # 大写字母转化为 小写
    HanziToPinyin.hanzi_2_pinyin("东方网力_entos").should == "dfwl_entos"
    HanziToPinyin.hanzi_2_pinyin("-").should == "_" # - 转化为 _
  end
  
  it "hanzi_to_pinyin method" do
    HanziToPinyin.hanzi_to_pinyin("我们").should == "wm"
    HanziToPinyin.hanzi_to_pinyin("北京东方网力科技股份有限公司").should == "bjdfwlkjgfyxgs"
  end
  
  it "hanzi_2_py method" do
    HanziToPinyin.hanzi_2_py("我们").should == "wo;men"
    HanziToPinyin.hanzi_2_py("yyf").should == "yyf"
    HanziToPinyin.hanzi_2_py("查理Smith").should == "cha,zha;li;Smith"
    HanziToPinyin.hanzi_2_py("你你").should == "ni;ni"
    HanziToPinyin.hanzi_2_py("郭轶").should == "guo;yi,die"
    HanziToPinyin.hanzi_2_py("宗志强").should == "zong;zhi;qiang,jiang"
    HanziToPinyin.hanzi_2_py("测试1").should == "ce;shi;1"
    HanziToPinyin.hanzi_2_py("2测试").should == "2;ce;shi"
    HanziToPinyin.hanzi_2_py("测3试").should == "ce;3;shi"
    HanziToPinyin.hanzi_2_py("测_试").should == "ce;_;shi"
    HanziToPinyin.hanzi_2_py("测-试").should == "ce;-;shi"
    HanziToPinyin.hanzi_2_py("金龙—技术支持").should == "jin;long,mang;—;ji;zhu,shu;zhi;chi"
    HanziToPinyin.hanzi_2_py(2).should == "2"
  end
  
  it "是否是汉字" do
    HanziToPinyin.is_hanzi?("我".ord).should be_true
    HanziToPinyin.is_hanzi?("a".ord).should be_false
    HanziToPinyin.is_hanzi?("_".ord).should be_false
    HanziToPinyin.is_hanzi?(2.ord).should be_false
  end
  
  it "是否是数字" do
    HanziToPinyin.is_number?("1".ord).should be_true
    HanziToPinyin.is_number?("w".ord).should be_false
  end
  
  it "是否是下划线"  do
    HanziToPinyin.is_underline?("_".ord).should be_true
    HanziToPinyin.is_underline?("豆".ord).should be_false
  end
  
  it "是否是横线" do
    HanziToPinyin.is_dash?("-".ord).should be_true
    HanziToPinyin.is_dash?("_".ord).should be_false
  end
  
end