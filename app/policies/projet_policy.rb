class ProjetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true  # Anyone can view a restaurant
  end

  def create?
    user.role = "developpeur"  # Only developer can creat a new project
  end

  def update?
    record.user == user  # Only project creator can update it
  end

  def destroy?
    record.user == user  # Only restaurant creator can update it
  end
end
