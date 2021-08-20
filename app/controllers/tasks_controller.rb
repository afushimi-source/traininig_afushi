class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url
      flash[:success] = 'Task was successfully created!'
    else
      render :new
      flash[:error] = 'An unexpected error has occurred.'
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task
      flash[:success] = 'Task was successfully updated!'
    else
      render :edit
      flash[:error] = 'An unexpected error has occurred.'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url
    flash[:success] = "Task was successfully destroyed!"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description)
  end
end
