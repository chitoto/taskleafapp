module Admin::UsersHelper

  def admin_user?
    unless current_user.admin
      redirect_to (root_path), notice: "管理者以外はアクセスできません！"
    end
  end

end
