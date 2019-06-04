class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to articles_path
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      redirect_to root_url
    end
  end

  def destroy
    session[:developer_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @developer = Developer.find_by(email: email)
    if @developer && @developer.authenticate(password) && @developer.name == "taisi20"
      session[:developer_id] = @developer.id
      return true
    else
      return false
    end
  end
end
