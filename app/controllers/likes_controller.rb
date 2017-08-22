class LikesController<ApplicationController

  def create
    @playlist= Playlist.find_by(id: params[:playlist_id])
    @playlist.like(current_user)
    redirect_to playlist_path(@playlist)
  end

  def destroy
    @user= User.find_by(id: params[:like][:user_id])
    @playlist = Playlist.find_by(id: params[:like][:playlist_id])
    @playlist.unlike(@user)
    redirect_to playlist_path(@playlist)
  end


end
