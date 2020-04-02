# encoding:utf-8
require 'json'
require 'yaml'
require 'cgi'

class HanziToPinyin
  
  VERSION = IO.read File.expand_path("../../VERSION",__FILE__)

  # Unicode中汉字开始点(16进制)
  @@hanzi_unicode_start = 19968
  # Unicode中汉字的结束点
  @@hanzi_unicode_end = 40869
  
  # 字母(10进制)
  @@letter_upcase_start = 65
  @@letter_upcase_end = 90
  @@letter_downcase_start = 97
  @@letter_downcase_end = 122
  
  # 数字(10进制)
  @@number_unicode_start = 48
  @@number_unicode_end = 57
  
  # 下划线(10进制)
  @@underline = 95
  
  # 横线(10进制)
  @@dash = 45
  
  # 汉字 unicode 编码(16进制)
  @@unicode = YAML.load(IO.read File.expand_path("../data/unicode_to_pinyin.yml",__FILE__))
  @@py = ::JSON.parse(IO.read File.expand_path("../data/hz2py.json",__FILE__))

  # 只取首字母
  def self.hanzi_2_pinyin(hanzi)
    hanzi = hanzi.force_encoding("utf-8")
    u_str = ''      
    hanzi.each_codepoint { |c|
      if is_hanzi?(c)
        unicode = c.to_s(16).upcase          
        u_str << @@unicode[unicode]
      else
        if c == 45 # -
          u_str << "_"
        else
          u_str << c.chr.downcase
        end          
      end        
    }
    u_str
  end
  class << self
    alias_method :hanzi_to_pinyin, :hanzi_2_pinyin
  end
  
  ##
  # 多音字,分隔 字字之间;分隔,字母原样保留
  #  查理Smith => "cha,zha;li;Smith"
  #  郭轶 => "guo;yi,die"
  #  我们 => "wo;men"
  #  宗志强 => "zong;zhi;qiang,jiang"
  def self.hanzi_2_py(hanzi)
    hanzi = hanzi.to_s.force_encoding("utf-8")
    @str = ''
    index = 0
    hanzi.each_char do |hz|
      if is_hanzi?(hz.ord)
        values = @@py[hz]
        append(values)
      else
        if @str.length == 0
          @str << hz.chr
        else
          if @str[-1] == ";"
            @str << hz.chr
          elsif @str[-1] =~ /[a-z]/i
            if is_hanzi?(hanzi[index-1].ord)
              @str << ";#{hz.chr}"
            else
              @str << hz.chr
            end
          else
            @str << ";#{hz.chr}"
          end
        end
      end
      index += 1
    end
    @str
  end
  class << self
    alias_method :hanzi_to_py, :hanzi_2_py
  end

  ##
  # 汉字转化为安全的 url
  def self.hanzi_2_url(hanzi)
    hanzi = hanzi.to_s.force_encoding("utf-8")
    arr = []
    hanzi.each_char do |hz|
      if is_hanzi?(hz.ord)
        value = @@py[hz].first
      else
        value = hz.chr
      end
      arr << value
    end
    ::CGI.escape arr.join('-')
  end
  class << self
    alias_method :hanzi_to_url, :hanzi_2_url
  end
  
  def self.append(values)
    if @str.length == 0
      @str << "#{values.join(',')}"
    else
      if @str[-1] == ";"
        @str << "#{values.join(',')}"
      else
        @str << ";#{values.join(',')}"
      end
    end
  end

  def self.is_hanzi?(hanzi_codepoint)
    hanzi_codepoint >= @@hanzi_unicode_start && hanzi_codepoint <= @@hanzi_unicode_end
  end
  
  def self.is_number?(number_codepoint)
    number_codepoint >= @@number_unicode_start && number_codepoint <= @@number_unicode_end
  end
  
  def self.is_underline?(underline_codepoint)
    underline_codepoint == @@underline
  end
  
  def self.is_dash?(codepoint)
    codepoint == @@dash
  end
  
  def self.is_letter?(codepoint)
    codepoint >= @@letter_upcase_start && codepoint <= @@letter_upcase_end or codepoint >= @@letter_downcase_start && codepoint <= @@letter_downcase_end
  end
    
end