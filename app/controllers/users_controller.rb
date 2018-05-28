class UsersController < ApplicationController
  def index
    @users = User.all
  end
 
  def show_user
    @id = params[:id]
    @user = User.find_by_id(@id)
  end

  def show

  end

end
