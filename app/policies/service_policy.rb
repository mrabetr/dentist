class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless doctor_or_admin?

      scope.all
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def index?
    doctor_or_admin?
  end

  def show?
    doctor_or_admin?
  end

  def create?
    doctor?
  end

  def update?
    doctor_owner?
  end

  def destroy?
    doctor_owner?
  end

  private

  def doctor?
    user.doctor
  end

  def doctor_owner?
    user == record.doctor.user
  end
end
