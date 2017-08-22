class RelationshipsController<ApplicationController

  def create
    @user = User.find_by(id: params[:followed_id])
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

end
