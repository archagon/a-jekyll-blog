# TODO: > infinite reload
# TODO: title id reset
# TODO: python script failure
# TODO: no regen
# TODO: find existing file

require 'shellwords'
require 'fileutils'

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

      initial_filepath = 'images/lilypond/%s' % image_name

      dirname = File.dirname('_' + initial_filepath)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      escaped_contents = Shellwords.escape(@contents)
      print "creating lilypond file: " + initial_filepath + "\n"
      system 'build/ly_to_svg_file.py %s "_%s"' % [escaped_contents, initial_filepath]

      FileUtils.mkdir_p(File.dirname('_site/%s.svg' % initial_filepath))
      FileUtils.cp('_%s.svg' % initial_filepath, '_site/%s.svg' % initial_filepath)

      '<img src="%s/images/lilypond/%s.svg">' % [config['baseurl'], image_name]
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