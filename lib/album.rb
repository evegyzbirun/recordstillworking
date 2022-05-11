require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')


class Album
  attr_reader :id, :name, :artist, :year, :genre
  @@albums = {}
  @@sold_albums = {}
  @@total_rows = 0

  def delete
    @@albums.delete(self.id)
  end

  def sell_album
    @@sold_albums[self.id] = Album.new(self.name, self.id, self.artist, self.year, self.genre)
    @@albums.delete(self.id)
  end

  def update(name, artist, year, genre)
    @name = name
    @artist = artist
    @year = year
    @genre = genre
  end
 
  def initialize(name, id, artist, year, genre)
      @name = name
      @id = id || @@total_rows += 1
      @artist = artist
      @year = year
      @genre = genre
  end
 
  def self.all
    @@albums.values()
  end

  def self.all_sold
    @@sold_albums.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id, self.artist, self.year, self.genre)
  end
  
  def ==(album_to_compare)
    self.name() == album_to_compare.name() && self.artist() == album_to_compare.artist && self.year() == album_to_compare.year() && self.genre() == album_to_compare.genre 
  end
  
  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def self.search(name)
    @@albums.each do |album| 
      if album[1].name == name
        return album[1]
      else
        "no albums match your search"
      end  
    end
  end 
  
  def self.sort
    @@albums.values.sort_by { |val| val.name}
  end
  
  def songs
    Song.find_by_album(self.id)
  end
end

