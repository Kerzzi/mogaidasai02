class Admin::BaseController < ActionController::Base

  # 这样admin中的controller，都继承自这个类，都使用admin布局
  layout 'admin/layouts/admin'
  
  before_action :auth_admin

  private
  def auth_admin
    unless logged_in? and current_user.is_admin?
      flash[:notice] = "请以管理员身份登录"
      redirect_to new_session_path
    end
  end
end
