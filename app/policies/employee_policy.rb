class EmployeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user && user.admin?
        scope.all
      end
    end
  end

  def edit?
    user && user.admin?
  end
  def update?
    user && user.admin?
  end
end