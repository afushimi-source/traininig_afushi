class LabelsController < ApplicationController
  def index
    @label = Label.new
    @labels = Label.page(params[:page])
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      flash[:success] = t 'labels.flash.edit_success'
      redirect_to labels_url
    else
      flash.now[:danger] = t 'labels.flash.edit_error'
      render :edit
    end
  end

  def create
    @label = Label.new(label_params)
    @task = Task.new
    redirect_to params[:original_url]
    if @label.save
      flash[:success] = t 'labels.flash.create_success'
    else
      flash[:danger] = t 'labels.flash.create_error'
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    flash[:success] = t 'labels.flash.destroy_success'
    redirect_to labels_url
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
