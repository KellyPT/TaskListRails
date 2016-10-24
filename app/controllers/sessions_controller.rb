class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index_logout, :create, :destroy]

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end

    session[:user_id] = @user.id
    redirect_to sessions_login_path
  end

  def index_login;
    @user = User.find(session[:user_id])
  end

  def index_logout; end

  def destroy
    session.delete(:user_id)
    redirect_to sessions_logout_path
  end
end
