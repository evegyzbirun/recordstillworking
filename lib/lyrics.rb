class Lyric 
  attr_reader :string, :song_id, :id
  attr_accessor :name, :song_id

  @@lyrics = {}
  @@total_rows = 0

  def initialize(string, song_id, id)
    @string = string
    @song_id = song_id
    @id = id || @@total_rows += 1
  end

  def save
    @@lyrics[self.song_id] = Lyric.new(self.string, self.song_id, self.id)
  end

  def self.find_by_song(song_id)
    lyrics = []
    @@lyrics.values.each do |lyric|
      if lyric.song_id == song_id
        lyrics.push(lyric)
      end
    end
    lyrics
  end

  def self.all
    @@lyrics.values()
  end

  def self.find(song_id)
    @@lyrics[song_id]
  end

  def song
    Song.find_by_album(self.album_id)
  end
end
