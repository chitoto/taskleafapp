class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(:limit)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
      if params[:title_key].present?
        @tasks = @tasks.search_title(params[:title_key])
        if params[:search_status].present?
          @tasks = @tasks.search_status(params[:search_status])
        end
      elsif params[:search_status].present?
        @tasks = @tasks.search_status(params[:search_status])
        if params[:title_key].present?
          @tasks = @tasks.search_title(params[:title_key])
        end
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:task_title, :task_description, :limit, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
