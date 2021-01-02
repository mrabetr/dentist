class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless doctor_or_admin?

      scope.all
    end
  end

  def index?
    admin?
  end

  def patients?
    doctor_or_admin?
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

  def doctor?
    user.doctor
  end

  def patient?
    user.profile_type == "Patient"
  end

  private

  def admin?
    user.admin
  end
end
