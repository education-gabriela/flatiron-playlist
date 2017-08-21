class UsersController<ApplicationController

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
  @user = User.find_by(id:params[:id])
end

def update
  @user = User.find_by(id: params[:id])
  @user.update(user_params(:name, :email))
  redirect_to user_path(@user)
end

private
def user_params(*args)
  params.require(:user).permit(*args)
end

end
