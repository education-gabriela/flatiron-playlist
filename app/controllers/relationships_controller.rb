class RelationshipsController<ApplicationController

  def create
    @user = User.find_by(id: params[:followed_id])
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def destroy
    #raise params.inspect
    @user= User.find_by(id: params[:relationship][:unfollow_user_id])
    current_user.unfollow(@user)
    redirect_to user_path(@user)
  end

end
