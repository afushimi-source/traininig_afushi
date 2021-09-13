class TasksController < ApplicationController
  def index
    @tasks = Task.search(params[:title_term], params[:status_term], params[:priority_term]).sort_deadline_on(params[:sort_deadline_on]).sort_priority(params[:sort_priority])
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
      redirect_to tasks_url
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
    params.require(:task).permit(:title, :description, :deadline_on, :status, :priority)
  end

  def search_params
    params.fetch(:search, {}).permit(:title, :status, :priority)
  end
end
