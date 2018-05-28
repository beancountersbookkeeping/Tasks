class TasksController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token, only: [:save_time, :update_task_time_spent]
  before_filter :authenticate_user!

  def tasks

  end

  def save_time
    Task.save_time(params)
  end

  def my_tasks   
   @task_type = "Active"
   if params[:anything] != nil then
    if params[:anything][:task_type] != nil then
     @task_type = params[:anything][:task_type].to_s
    end
   end
   @tasks = Task.all.limit(0)
   if @task_type.to_s == "Active" then
     @tasks = Task.where(:user_id => current_user.id).where(:status => 'Active').where(:archived => false)
   elsif @task_type.to_s == "Completed" then
     @tasks = Task.where(:user_id => current_user.id).where(:status => 'Completed').where(:archived => false)
   end
   @nr_tasks = @tasks.size
  end

  def complete_task
    Task.complete_task(params)
    flash[:success] = "Task was marked as completed."
    redirect_to :back
  end

  def activate_task
    Task.activate_task(params)
    flash[:success] = "Task was activated."
    redirect_to :back
  end

  def update_task_time_spent
    @id = params[:pk]
    @value = params[:value]
    @task = Task.find_by_id(@id)
    if @task != nil then 
      @task.time = @value
      @task.save
    end
  end

end
