English User See: [README.EN.md](./README.EN.md)

hanzi_to_pinyin
==
* 获取汉字首字母
* 获取汉字完整拼音
* 把汉字转化为安全的 url

## 安装
ruby version <= 2.1.0

    $ gem 'hanzi_to_pinyin', '1.0.0', require: 'hanzi_to_pinyin'

ruby version >=2.2.0

    $ gem 'hanzi_to_pinyin', require: 'hanzi_to_pinyin'

## 使用

```ruby
  # 获取首字母
  $ HanziToPinyin.hanzi_to_pinyin("中华人民共和国") #=> "zhrmghg"
  $ HanziToPinyin.hanzi_2_pinyin("中华人民共和国") #=> "zhrmghg"
  $ HanziToPinyin.hanzi_to_pinyin("喜欢Ruby") #=> "xhruby"
  $ HanziToPinyin.hanzi_2_pinyin("喜欢Ruby") #=> "xhruby"

  # 判断是否是汉字
  $ HanziToPinyin.is_hanzi?("你") #=> true
  $ HanziToPinyin.is_hanzi?("a") #=> false

  # 获取完整拼音
  # 多音字,分隔 字字之间;分隔,字母数字保留不变
  $ HanziToPinyin.hanzi_2_py("我们") #=> "wo;men"
  $ HanziToPinyin.hanzi_2_py("yyf") #=> "yyf"
  $ HanziToPinyin.hanzi_2_py("查理Smith") #=> "cha,zha;li;Smith"
  $ HanziToPinyin.hanzi_2_py("测试1") #=> "ce;shi;1"
  $ HanziToPinyin.hanzi_2_py("测_试") #=> "ce;_;shi"
  $ HanziToPinyin.hanzi_2_py("测-试") #=> "ce;-;shi"
  $ HanziToPinyin.hanzi_2_py(2) #=> "2"

  # 判断是否是数字
  $ HanziToPinyin.is_number?("1".ord) #=> true
  $ HanziToPinyin.is_number?("a".ord) #=> false

  # 判断是否是下划线
  $ HanziToPinyin.is_underline?("_".ord) #=> true
  $ HanziToPinyin.is_underline?("豆豆") #=> false
  
  # 判断是否是连接符
  $ HanziToPinyin.is_dash?("-".ord) #=> true

  # 汉字转化为安全的 url
  $ HanziToPinyin.hanzi_to_url("双11活动") #=> "shuang-1-1-huo-dong"
  $ HanziToPinyin.hanzi_to_url("双12活动&name=xxx") #=> "shuang-1-2-huo-dong-%26-n-a-m-e-%3D-x-x-x"
```

## 测试
  
    $ rake spec
    
或者跑某个测试用例

    $ rspec spec/hanzi_to_pinyin/hanzi_to_pinyin_spec.rb -l 21

## ChangeLog
## 1.0.0
  * ruby 版本 < 2.1.0 使用

## 2.0.0
  * 升级 Rake 版本解决 Rake 安全漏洞问题
  ```
    CVE-2020-8130
    moderate severity
    Vulnerable versions: <= 12.3.2
    Patched version: 12.3.3
    There is an OS command injection vulnerability in Ruby Rake before 12.3.3 in Rake::FileList when supplying a filename that begins with the pipe character |.
  ```
  * 支持 Ruby >= 2.2.0

## 2.0.1
  * 修复"嗯"转化报错

## 版权

Copyright (c) 2011 wxianfeng. See LICENSE.txt for further details.
