class CompaniesController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin

  private 

  def require_admin
    #puts "Current user: " + current_user.role.to_s
    if current_user.role.to_s != "admin" then      
      flash[:notice] = "Admin required to view companies."
      redirect_to root_path
    end
  end

  public

  def index
    @companies = Company.all
  end

  
  def companies
    @companies_grid = initialize_grid(Company)

  end

end
