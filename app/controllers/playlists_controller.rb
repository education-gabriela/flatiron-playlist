class PlaylistsController<ApplicationController
  before_action :require_login

  def index
    @my_playlists = Playlist.where(user: current_user).limit(5)
    @others_playlists = Playlist.where.not(user: current_user).limit(5)
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user_id = current_user.id
    if @playlist.save
      redirect_to playlist_path(@playlist)
    else
      redirect_to new_playlist_path
    end
  end

  def show
    @playlist = Playlist.find_by(id: params[:id])
    @songs = Song.joins(:playlist_songs).where(playlist_songs: {playlist: @playlist}).includes(:artist).page params[:page]
    @like = Like.new
  end

  def destroy
    Playlist.find_by(params[:id]).destroy
    redirect_to playlists_path
  end

  def edit
    @playlist = Playlist.find_by(id: params[:id])
  end

  def update
    @playlist = Playlist.find_by(id: params[:id])
    @playlist.update(playlist_params)
    redirect_to playlist_path(@playlist)
  end

  def add_songs
    @playlist = Playlist.find_by(id: params[:playlist][:id], user: current_user)
    song_ids = (params[:playlist][:song_ids].map(&:to_i) + @playlist.song_ids).uniq if @playlist && params[:playlist]

    if @playlist && @playlist.update(song_ids: song_ids)
      redirect_to playlist_path(@playlist)
    else
      flash[:messages] = ["Playlist not found."]
      redirect_to songs_path
    end
  end

  def delete_songs
    @playlist = Playlist.find_by(id: params[:id], user: current_user)

    song_ids = @playlist.song_ids
    if params[:playlist]
      song_ids -= params[:playlist][:song_ids].map(&:to_i)
    end

    unless @playlist && @playlist.update(song_ids: song_ids)
      flash[:messages] = ["Playlist not found."]
    end

    redirect_to playlist_path(@playlist)
  end

  def likes
    @playlist = Playlist.find_by(id: params[:id])
    @likes = @playlist.likes
    render 'show_like'
  end

  def owned
    @playlists = current_user.playlists.page params[:page]
    render 'paginated', locals: {color: "pink", title: "My Playlists"}
  end

  def explore
    @playlists = Playlist.where.not(user: current_user).page params[:page]
    render 'paginated', locals: {color: "purple", title: "Explore Playlists"}
  end

  private
  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
