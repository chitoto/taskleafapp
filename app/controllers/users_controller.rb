class UsersController < ApplicationController
  before_action :current_user_show?, only: [:show]
  before_action :current_user?, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def current_user_show?
    unless current_user.id == params[:id].to_i
      redirect_to tasks_path, notice:"他ユーザー情報は閲覧できません！"
    end
  end

  def current_user?
    if current_user
      redirect_to root_path, notice: "ログアウトしてください！"
    end
  end
end
