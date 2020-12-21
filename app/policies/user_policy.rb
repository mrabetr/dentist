class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless user.admin

      scope.all
    end
  end

  def index?
    admin?
  end

  def create?
    doctor_or_admin?
  end

  def impersonate?
    admin?
  end

  def stop_impersonating?
    true
  end

  private

  def admin?
    user.admin
  end
end
