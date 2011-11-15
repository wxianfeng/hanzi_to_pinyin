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
    HanziToPinyin.hanzi_2_py("查理Smith").should == "cha,zha;li"
  end
  
  it "是否是汉字" do
    HanziToPinyin.is_hanzi?("我".ord).should be_true
    HanziToPinyin.is_hanzi?("a".ord).should be_false
    HanziToPinyin.is_hanzi?("_".ord).should be_false
    HanziToPinyin.is_hanzi?(2.ord).should be_false
  end
end