class taskPolicy < ApplicationPolicy

  attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def update?
    user.admin? or not task.private?
  end
  
  def admin_list?
    user.admin?
  end
end