class ArtistsController < ApplicationController
  before_action :require_login
  def index
    @artists = Artist.joins(:songs).group(:id).order(:name).select(:id, :name, "count(*) AS total").page params[:page]
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.valid?
      @artist.save
      redirect_to artist_path(@artist)
    else
      redirect_to new_artist_path
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    if @artist.update(artist_params)
      redirect_to artist_path(@artist)
    else
      redirect_to edit_artist_path(@artist)
    end
  end

  def search
    term = params[:term]
    search = Artist.search do
      fulltext term
    end
    @artists = search.results
    @artists = Artist.joins(:songs).where(id: @artists.pluck(:id)).group(:id).order(:name).select(:id, :name, "count(*) AS total").page params[:page]
    render "artists/index"
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
