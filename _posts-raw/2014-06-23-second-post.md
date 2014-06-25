---
layout: post
title: "Second post!"
date: 2014-06-23 01:52:07 +0200
comments: true
categories: programming
---
# More Stuff

More stuff. Have a footnote.[^1]

## Another Header

Some content here.

## Some Music

{% lilypond %}
    <<
    \chords {
        c1:m7 f2:7 c2
    }
    \relative c'' {
        g2 es8( c4) es8
        f8 es d c~ c2
    }
    \addlyrics {
        You are
        the sky and my TRAIN,
    }
    >>
{% endlilypond %}

{% lilypond %}
    {
        % middle tie looks funny here:
        <c' d'' b''>8. ~ <c' d'' b''>8
    }
{% endlilypond %}

[^1]: Let's try a footnote.