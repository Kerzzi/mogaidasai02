class SessionsController < ApplicationController
  def new

  end

  def create
    if user = login(params[:email], params[:password])
      #这里的uuid来源于user model中的uuid
      update_browser_uuid user.uuid

      flash[:notice] = "登陆成功"
      redirect_to root_path
    else
      flash[:notice] = "邮箱或者密码不正确"
      redirect_to new_session_path
    end
  end

# destroy在sorcery的设定中，必须传递一个member，即用户的id，所以要有个路由
  def destroy
    logout
    flash[:notice] = "退出成功"
    redirect_to root_path
  end
end
