module SessionsHelper
  def developer
    @developer ||= Developer.find_by(id: session[:developer_id])
  end
  
  def logged_in?
    !!developer
  end
end
