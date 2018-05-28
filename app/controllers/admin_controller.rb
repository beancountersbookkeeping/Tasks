class AdminController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :require_admin

  private 
  
  def require_admin
    unless current_user && current_user.role == 'admin'
      flash[:alert] = "You are not an admin."
      redirect_to my_tasks_path
    end        
  end

  public 

  def tasks
    @tasks = Task.all

    @users = User.all
    @hash_users = Hash.new
    for @user in @users do 
      @hash_users[@user.email] = @user.email
    end

    @companies = Company.all
    @hash_companies = Hash.new
    for @company in @companies do 
      @hash_companies[@company.name] = @company.name
    end

    @tasks_grid = initialize_grid(Task)
  end

  def companies
    @companies = Company.all
  end

  def show_task
    @task = Task.find(params[:id])
  end

  def new_task
    @company_id = params[:company_id]    
  end

  def create_task   
    @errors = Task.save_task_errors(params, current_user)
    if @errors == "" then
      Task.save_task(params, current_user)
      flash[:notice] = "Task was successfully saved."
      redirect_to admin_new_task_path
    else
      flash.now[:alert] = @errors 
      flash[:new_task_title] = params[:anything][:title]
      flash[:new_task_recreate_task_days] = params[:anything][:recreate_task_days]
      render admin_new_task_path
    end    
  end

   def destroy_task
     @task = Task.find(params[:id])
     if @task != nil then 
       if @task.archived == true then 
	 @task.archived = false 
         flash[:notice] = "Task was successfully un-archived."
       elsif @task.archived == false then 
	 @task.archived = true 
         flash[:notice] = "Task was successfully archived."
       end
       @task.save       
     else
       flash[:alert] = "No such task."
     end
     redirect_to :back
   end

  def recreate_tasks
    Task.create_todays_tasks
    redirect_to :back
    #render layout: false
  end

  def show_company
    @company = Company.find_by_id(params[:id])
    @tasks = Task.where(:company_id => @company.id)
    @user = Company.find_by_id(params[:user_id])
  end

  def new_company
    @users = User.all

  end

  def edit_company
    @company = Company.find(params[:id])
    @users = User.all
  end

  def create_company
    @errors = Company.save_company_errors(params, current_user)

    if @errors == "" then
      Company.save_company(params, current_user)
      flash[:notice] = "Company was successfully saved."
      redirect_to new_company_path
    else
      flash[:alert] = @errors
      flash[:new_company_name] = params[:company][:name]
      redirect_to new_company_path
    end
  end

 def update_company
   @errors = Company.update_company_errors(params)
   if @errors == "" then
     Company.update_company(params)
     flash[:notice] = "Company was successfully updated."
     redirect_to companies_path
   else
     flash[:error] = @errors
     redirect_to :back
   end
  end

 def destroy_company
  @company = Company.find(params[:id])
  if @company != nil then 
    Company.destroy_company(@company)
    flash[:notice] = "Company and all of its tasks have been destroyed."
    redirect_to companies_path
  else
    flash[:notice] = "No such company"
    redirect_to :back
  end
 end



end
