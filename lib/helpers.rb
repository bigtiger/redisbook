include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Tagging

require 'nokogiri'

def svg(x)
  %{<script type="image/svg+xml">} + x.gsub(/\n|\r|^\s+/, '') + %{</script>}
end

def lorem(s = 5)
  ("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. " * 3).split('. ').first(s).join(". ")
end

def chapters
  @items.select { |i| Fixnum === i[:chapter] }.sort_by { |i2| i2[:chapter].to_i }
end

def subsections_of_chapter(chapter)
  doc = Nokogiri::HTML(chapter.compiled_content)
  subsections = []
  section_id = 0
  doc.css("h2").each do |h|
    title = h.css(".name").inner_text
    section_id += 1
    subsections << { :number => section_id, :title => title, :anchor => h['id'] }
  end
  subsections
end