# encoding:utf-8
require "json"

class HanziToPinyin
  
  VERSION = IO.read File.expand_path("../../VERSION",__FILE__)

  # Unicode中汉字开始点(16进制)
  @@hanzi_unicode_start = 19968
  # Unicode中汉字的结束点
  @@hanzi_unicode_end = 40869
  
  # 数字(10进制)
  @@number_unicode_start = 48
  @@number_unicode_end = 57
  
  # 下划线(10进制)
  @@underline = 95
  
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
    alias_method :hanzi_to_pinyin , :hanzi_2_pinyin
  end
  
  ##
  # 只处理汉字和数字和_    多音字,分隔 字字之间;分隔
  #   查理Smith => "cha,zha;li"
  #   郭轶 => "guo;yi,die"
  #   我们 => "wo;men"
  #   宗志强 => "zong;zhi;qiang,jiang"
  def self.hanzi_2_py(hanzi)
    hanzi = hanzi.force_encoding("utf-8")
    str = ''
    hanzi.each_char do |hz|
      if is_number?(hz.ord) or is_underline?(hz.ord)
        if str.length == 0
          str << hz.chr
        else
          if str[-1] == ";"
            str << hz.chr
          else
            str << ";#{hz.chr}"
          end
        end
      elsif is_hanzi?(hz.ord)
        values = @@py[hz]
        if values.size > 1
          if str.length == 0
            str << "#{values.join(',')}"
          else
            if str[-1] == ";"
              str << "#{values.join(',')}"
            else
              str << ";#{values.join(',')}"
            end
          end
        else
          if str.length == 0
            str << "#{values.join};"
          else
            if str[-1] == ";"
              str << "#{values.join}"
            else
              str << ";#{values.join}"
            end
          end
        end
      end
    end
    str
  end
  class << self
    alias_method :hanzi_to_py , :hanzi_2_py
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
    
end