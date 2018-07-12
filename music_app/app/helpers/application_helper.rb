module ApplicationHelper
  def ugly_lyrics(lyrics)
    lyrics = lyrics.split("\n").map { |line| "&#9835;".html_safe + h(" #{line}") }

    html = "<pre>"
    lyrics.each { |line| html += line + "\n" }
    html.html_safe
  end
end
