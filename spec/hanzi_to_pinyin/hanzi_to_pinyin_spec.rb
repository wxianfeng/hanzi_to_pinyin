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
    HanziToPinyin.hanzi_2_py("查理Smith").should == "cha;li;Smith"
    HanziToPinyin.hanzi_2_py("你你").should == "ni;ni"
    HanziToPinyin.hanzi_2_py("郭轶").should == "guo;yi"
    HanziToPinyin.hanzi_2_py("宗志强").should == "zong;zhi;qiang"
    HanziToPinyin.hanzi_2_py("测试1").should == "ce;shi;1"
    HanziToPinyin.hanzi_2_py("2测试").should == "2;ce;shi"
    HanziToPinyin.hanzi_2_py("测3试").should == "ce;3;shi"
    HanziToPinyin.hanzi_2_py("测_试").should == "ce;_;shi"
    HanziToPinyin.hanzi_2_py("测-试").should == "ce;-;shi"
    HanziToPinyin.hanzi_2_py("金龙—技术支持").should == "jin;long;—;ji;shu;zhi;chi"
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
  
  it "常用字去掉生僻读音" do
    HanziToPinyin.hanzi_2_py("豉").should == "chi"
    HanziToPinyin.hanzi_2_py("空调").should == "kong;diao,tiao"
    HanziToPinyin.hanzi_2_py("帝都").should == "di;du,dou"
    HanziToPinyin.hanzi_2_py("哦").should == "e,o"
    HanziToPinyin.hanzi_2_py("可恶").should == "ke;e,wu"
    HanziToPinyin.hanzi_2_py("吐鲁番").should == "tu;lu;fan,pan" 
    HanziToPinyin.hanzi_2_py("仿佛").should == "fang;fo,fu"
    HanziToPinyin.hanzi_2_py("乾隆").should == "qian;long"
    HanziToPinyin.hanzi_2_py("信息部").should == "xin;xi;bu"
    HanziToPinyin.hanzi_2_py("蜈蚣").should == "wu;gong"
    HanziToPinyin.hanzi_2_py("朝阳门").should ==  "zhao,chao;yang;men"
    HanziToPinyin.hanzi_2_py("女人").should == "nÜ;ren" 
    HanziToPinyin.hanzi_2_py("研发中心").should == "yan;fa;zhong;xin"
  end

  it "汉字转化为安全的 url" do
    HanziToPinyin.hanzi_to_url("双11活动").should == "shuang-1-1-huo-dong"
    HanziToPinyin.hanzi_to_url("双12活动&name=xxx").should == "shuang-1-2-huo-dong-%26-n-a-m-e-%3D-x-x-x"
  end
end
