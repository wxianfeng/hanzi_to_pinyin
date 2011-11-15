# encoding:utf-8
require "json"

class HanziToPinyin
  
  VERSION = IO.read File.expand_path("../../VERSION",__FILE__)

  # Unicode中汉字开始点
  @@hanzi_unicode_start=19968
  # Unicode中汉字的结束点
  @@hanzi_unicode_end=40869
  # 汉字 unicode 编码(16进制)
  @@unicode = YAML.load(IO.read File.expand_path("../data/unicode_to_pinyin.yml",__FILE__))
  @@py = ::JSON.parse(IO.read File.expand_path("../data/hz2py.json",__FILE__))

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
  # 只处理汉字 多音字,分隔 字字之间;分隔
  def self.hanzi_2_py(hanzi)
    hanzi = hanzi.force_encoding("utf-8")
    str = ''
    hanzi.each_char do |hz|
      if is_hanzi?(hz.ord)
        values = @@py[hz]
        if values.size > 1
          str << "#{values.join(',')}"
        else
          if str.length == 0
            str << "#{values.join}"
          else
            str << ";#{values.join}"
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
    hanzi_codepoint>=@@hanzi_unicode_start&&hanzi_codepoint<=@@hanzi_unicode_end
  end    
    
end