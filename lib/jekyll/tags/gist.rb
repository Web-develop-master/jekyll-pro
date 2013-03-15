# Gist Liquid Tag
#
# Example:
#    {% gist 1234567 %}
#    {% gist 1234567 file.rb %}

module Jekyll
  class GistTag < Liquid::Tag
    def render(context)
      if tag_contents = @markup.match(/(\d+) (.*)/)
        gist_id, filename = tag_contents[1].strip, tag_contents[2].strip
        gist_script_tag(gist_id, filename)
      else
        "Error parsing gist id"
      end
    end

    private

    def gist_script_tag(gist_id, filename=nil)
      if filename.empty?
        "<script src=\"https://gist.github.com/#{gist_id}.js\">\s</script>"
      else
        "<script src=\"https://gist.github.com/#{gist_id}.js?file=#{filename}\">\s</script>"
      end
    end
  end
end

Liquid::Template.register_tag('gist', Jekyll::GistTag)
