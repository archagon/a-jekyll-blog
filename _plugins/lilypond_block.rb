module Jekyll
  class LilypondBlock < Liquid::Block

    # def initialize(tag_name, text, tokens)
    #   super
    #   @text = text
    # end

    def render(context)
      # keep counter of images in post, append
      "<img src='../../../../images/test.svg' width=700></img>"
    end
  end
end

Liquid::Template.register_tag('lilypond', Jekyll::LilypondBlock)