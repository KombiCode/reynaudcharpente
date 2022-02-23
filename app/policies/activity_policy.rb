class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user && user.admin?
        scope.all
      end
    end
  end

  def new?
    user && user.admin?
  end
  def create?
    user && user.admin?
  end
  def edit?
    user && user.admin?
  end
  def update?
    user && user.admin?
  end
  def destroy?
    user && user.admin?
  end
end