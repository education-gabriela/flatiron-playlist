class SessionsController<ApplicationController

  def new
  end

  def create
    if request.env['omniauth.auth']
      if @user = User.find_by(email: auth['info']['email'])
        session[:user_id] = @user.id
        redirect_to root_path
      else
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
    end
      if @user.save
      session[:user_id] = @user.id
      redirect_to login_path
    else
      redirect_to login_path
    end
  end

    else
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :'users/new'
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
