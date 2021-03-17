class PatientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless doctor_or_admin?

      scope.all
    end
  end

  def show?
    doctor_or_admin?
  end

  def update?
    doctor_or_admin?
  end

  def destroy?
    doctor_or_admin?
  end

  def send_password_email?
    doctor_or_admin?
  end
end
