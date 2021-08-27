class TasksController < ApplicationController
  def index
    direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    column = Task.column_names.include?(params[:column]) ? params[:column] : 'created_at'
    @tasks = Task.all.order("#{column} #{direction}")
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
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = t 'tasks.flash.edit_success'
      redirect_to @task
    else
      flash.now[:error] = t 'tasks.flash.edit_error'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = t 'tasks.flash.destroy_success'
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline)
  end
end
