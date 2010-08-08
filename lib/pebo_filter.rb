class PeboFilter < Nanoc3::Filter
  identifier :pebo
  type :text
  
  def run(content, params = {})
    
    if @item[:status] =~ /\bnotstarted\b/
      content = %{WARNING: This document has <em>not yet been started</em> and is here for organizational purposes only.\n} + content
    end

    if @item[:status] =~ /\incomplete\b/
      content = %{WARNING: Beware that this document has been started but is *incomplete.*\n} + content
    end
    
    content.gsub!(/^(NOTE|OK|HELP|INFO|WIZARD|WARNING|TERMINAL|BOOKS|CONFIG|BAD|MATH)\:\s+(.*)$/) { %{<div class="note type-#{$1.downcase}"><img src="/pebo/#{$1.downcase}.png" class="icon" /><div class="content" markdown="span">#{$2}</div></div>} }
    
    # Support ASCIIDoc style {title} interpolations
    content.gsub!(/\{(\w+)\}/) { @item[$1.downcase.to_sym] }
    
    # Support ASCIIDoc style source inclusion and highlighting
    content.gsub!(/^\[source(,?)(\w*)\]\n\-+\n(.*?)\n\-+/m) {
      if $1 == ","
        IO.popen("pygmentize -f html -l " + $2, 'w+') do |f|
          f.write($3)
          f.close_write
          f.read     
        end
      else
        %{<div class="highlight"><pre>#{$3}</pre></div>}
      end
    }

    # Convert ASCIIDoc style headings to Markdown ones
    content.gsub!(/^(\=+)(s?)\s(.+)$/) { "#" * ($1.length - 1) + $2 + " " + $3 }    
    #content.gsub!(/^(.*)\n([\-\~\^\+]+)\n/) { ("#" * (%w{- ~ ^ +}.index($2[0].chr) + 1)) + " " + $1 }
    content.gsub!(/^\.(\w.*)$/) { "#### " + $1 }
    
    # Convert ASCIIDoc style line breaks
    content.gsub!(/\s\+\n/, "  \n")
    
    content.gsub!(/\+(.+)\+/) { "`#{$1}`" }
    
    
    # Add section numbers to specially denoted headings if the content is book related
    if @item[:content_class] =~ /\bbook\b/
      section_number = 0
      content.gsub!(/^(\#+)(.*)$/) do |part|
        if $1.length == 2
          section_number += 1
          %{<h2 id="c#{@item[:chapter]}-s#{section_number}"><div class="section">#{@item[:chapter]}.#{section_number}</div><span class="name">#{$2}</span></h2>}
        elsif $1.length == 1
          %{<h1 id="c#{@item[:chapter]}"><div class="section">#{@item[:chapter]}</div><span class="name">#{$2}</span></h1>}
        else
          part
        end
      end
    end
    
    content
  end
end