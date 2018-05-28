class UserPolicy < ApplicationPolicy

  def destroy?
    user.present?
  end

end