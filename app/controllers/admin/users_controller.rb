class Admin::UsersController < ApplicationController
  before_action :authenticate_user
  before_action :admin_user?
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order("created_at DESC")
    @users = @users.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザー作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"ユーザー更新しました！"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:"ユーザー削除しました！"
    else
      redirect_to admin_users_path, notice:"ユーザー削除できませんでした！"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
