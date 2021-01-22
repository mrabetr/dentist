class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless doctor_or_admin?

      scope.all
    end
  end

  def index?
    doctor_or_admin?
  end

  def show?
    doctor_or_admin?
  end

  def create?
    true
  end
end
