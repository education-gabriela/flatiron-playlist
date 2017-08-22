class SessionsController<ApplicationController

  def new
    @user = User.new
  end

  def create
  #   if request.env['omniauth.auth']
  #     if @user = User.find_by(email: auth['info']['email'])
  #       session[:user_id] = @user.id
  #       redirect_to root_path
  #     else
  #     @user = User.new
  #     @user.name = auth['info']['name']
  #     @user.email = auth['info']['email']
  #   end
  #     if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to login_path
  #   else
  #     redirect_to login_path
  #   end
  # end
  #
  #   else
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end


  def destroy
    session.clear
    redirect_to root_path
  end

private

def auth
  request.env['omniauth.auth']
end

end
