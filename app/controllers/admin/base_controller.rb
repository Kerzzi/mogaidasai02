class Admin::BaseController < ActionController::Base

  # 这样admin中的controller，都继承自这个类，都使用admin布局
  layout 'admin/layouts/admin'

end
