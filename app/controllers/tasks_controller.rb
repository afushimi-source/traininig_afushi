class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url
      flash[:success] = "Task was successfully created!"
    else
      render :new
      flash[:error] = "An unexpected error has occurred."
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task
      flash[:success] = "Task was successfully updated!"
    else 
      render :edit
      flash[:error] = "An unexpected error has occurred."
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
