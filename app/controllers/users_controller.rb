class UsersController < ApplicationController
  before_action :current_user?, only: [:show]

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

  def current_user?
    unless current_user.id == params[:id].to_i
      redirect_to tasks_path, notice:"他ユーザー情報は閲覧できません！"
    end
  end
end
