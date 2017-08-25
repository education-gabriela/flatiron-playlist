class SongsController < ApplicationController
  before_action :require_login
  def index
    @songs = Song.order(:title).includes(:artist).includes(:playlists).includes(:genres).page params[:page]
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.valid?
      @song.save
      redirect_to song_path(@song)
    else
      redirect_to new_song_path
    end
  end

  def show
    @song = Song.find(params[:id])
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    if @song.update(song_params)
      redirect_to song_path(@song)
    else
      redirect_to edit_song_path(@song)
    end
  end

  def search
    term = params[:term]
    search = Song.search do
      fulltext term
    end
    @songs = search.results
    @songs = Song.order(:title).includes(:artist).includes(:playlists).includes(:genres).where(id: @songs.pluck(:id)).page params[:page]
    render "songs/index"
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_id, :spotify_id, genre_ids: [])
  end
end
