include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Tagging

def svg(x)
  %{<script type="image/svg+xml">} + x.gsub(/\n|\r|^\s+/, '') + %{</script>}
end

def lorem(s = 5)
  ("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. " * 3).split('. ').first(s).join(". ")
end