module Jekyll
  class LilypondUnGenerator < Generator
    def generate(site)
      should_regen = site.config["lilypond_regen"] == true
      # TODO: clear out directory
    end
  end
end