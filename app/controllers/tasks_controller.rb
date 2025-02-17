class TasksController < ApplicationController
  before_action :logged_in_user

  def index
    @tasks = current_user.tasks.eager_load(:labels)
                         .search(params)
                         .sort_column(params)
                         .page(params[:page])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @label = Label.new
  end

  def edit
    @task = Task.find(params[:id])
    @label = Label.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = t 'tasks.flash.create_success'
      redirect_to tasks_url
    else
      flash.now[:danger] = t 'tasks.flash.create_error'
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = t 'tasks.flash.edit_success'
      redirect_to tasks_url
    else
      flash.now[:danger] = t 'tasks.flash.edit_error'
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
    params.require(:task).permit(:title, :description, :deadline_on, :status, :priority, label_ids: [])
  end
end
