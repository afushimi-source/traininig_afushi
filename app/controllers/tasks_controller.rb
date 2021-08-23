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
      flash[:success] = t 'tasks.flash.create_success'
      redirect_to tasks_url
    else
      flash.now[:error] = t 'tasks.flash.create_error'
      render :new
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = t 'tasks.flash.edit.success'
      redirect_to @task
    else
      flash.now[:error] = t 'tasks.flash.edit.error'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = t 'tasks.flash.success'
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
