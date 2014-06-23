# TODO: > infinite reload
# TODO: python script failure
# TODO: no regen
# TODO: find existing file

require 'shellwords'

module Jekyll
  class LilypondBlock < Liquid::Block

    @@counter = 0

    def initialize(tag_name, name, tokens)
      @contents = tokens[0]
      @@counter += 1
      @id = @@counter
      @name = name
      super
    end

    def render(context)
      config = context.registers[:site].config
      should_regen = config['lilypond_regen'] == true

      page = context.environments.first['page']
      image_name = '%s-%s' % [slug(page['id']), (@name.empty? ? @id.to_s : slug(@name))]

      escaped_contents = Shellwords.escape(@contents)
      system 'build/ly_to_svg_file.py %s "images/lilypond/%s"' % [escaped_contents, image_name]

      '<img src="/images/lilypond/%s.svg">' % [image_name]
    end

    # stolen from Jekyll's env.rb; modified slightly
    def slug(title)
      if !title.empty?
        title.downcase.gsub(/[^\w]/, " ").strip.gsub(/\s+/, '-')
      end
    end
  end
end

Liquid::Template.register_tag('lilypond', Jekyll::LilypondBlock)