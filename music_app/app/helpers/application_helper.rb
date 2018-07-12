module ApplicationHelper
  def ugly_lyrics(lyrics)
    lyrics = lyrics.split("\n").map { |line| "&#9835;".html_safe + h(" #{line}") }

    html = "<pre>"
    lyrics.each do |line|
      html += line
      html += "\n" unless line == lyrics.last
    end
    html += "</pre>"
    html.html_safe
  end
end
