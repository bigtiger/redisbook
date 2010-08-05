class PeboFilter < Nanoc3::Filter
  identifier :pebo
  type :text
  
  def run(content, params = {})
    if @item[:chapter] && !@item[:chapter].to_s.empty?
      content = %{<h1><div class="chapter">#{@item[:chapter]}</div>#{@item[:title]}</h1>} + content
      
      section_number = 0
      content.gsub!(/^\#\#s.*$/) do |part|
        parts = /\#\#s\s+(.*)/.match(part)
        %{<h2><div class="chapter">#{@item[:chapter]}.#{section_number += 1}</div>#{parts[1]}</h2>}
      end
    end
    
    content
  end
end