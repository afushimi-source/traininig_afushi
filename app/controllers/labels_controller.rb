class LabelsController < ApplicationController
  def index
    @labels = Label.all.page(params[:page])
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      flash[:success] = t 'labels.flash.edit_success'
      redirect_to labels_url
    else:
      flash.now[:danger] = t 'labels.flash.edit_error'
      render :edit
    end
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to tasks_url
      flash[:success] = t 'labels.flash.create_success'
    else
      redirect_to tasks_url
      flash.now[:danger] = t 'labels.flash.create_error'
      render :index
    end
  end

  def destroy
    @label = Label.find(patams[:id])
    @label.destroy
    flash[:success] = t 'labels.flash.destroy_success'
    redirect_to labels_url
  end

  private

  def label_params
    params.require(:label).premit(:name)
  end
end
