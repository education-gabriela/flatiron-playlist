class SessionsController<ApplicationController

  def new
    @user = User.new
  end

  def create
  if request.env['omniauth.auth']
     @user = User.from_omniauth(request.env['omniauth.auth'])
      if @existing_user = User.find_by_email(@user.email)
        session[:user_id] = @existing_user.id
        redirect_to root_path
     else
       render 'users/new'
     end
  else
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'sessions/new'
    end
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
