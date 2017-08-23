class UsersController<ApplicationController

  def index
    @users= User.order(:name).includes(:playlists).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(:name, :email, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :'/users/new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params(:name, :email))
    redirect_to user_path(@user)
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def search
    @users = User.search { fulltext params[:term] }.results
    render "users/index"
  end

  private
  def user_params(*args)
    params.require(:user).permit(*args)
  end

end
