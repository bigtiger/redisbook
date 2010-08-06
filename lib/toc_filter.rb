#class TOCFilter < Nanoc3::Filter
#  identifier :toc
#  type :text
#  
#  def run(content, params = {})
#    require 'nokogiri'
#    
#    toc = ''
#    doc = Nokogiri::HTML(content)
#    ap = 0
#    hc = 0
#    sc = 0
#    doc.traverse do |h2|
#      next unless %w{h2 h3}.include?(h2.name)
#      h2["id"] = "ap#{ap += 1}"
#      if h2.name == "h2"
#        hc += 1
#        sc = 1
#        toc += %{<li class="h2"><a href="#ap#{ap}">#{hc} #{h2.inner_text}</a>} 
#      else
#        toc += %{<li class="h3"><a href="#ap#{ap}">#{hc}.#{sc} #{h2.inner_text}</a>}         
#        sc += 1 
#      end
#      
#      toc += %{</li>}
#    end
#    
#    # TODO: Stop sticking DOCTYPE, HTML, and BODY tags on!!
#    doc.to_html.gsub('<!-- toc -->', %{<div class="toc"><h3>Contents</h3><ol>#{toc}</ol></div>})
#  end  
#end