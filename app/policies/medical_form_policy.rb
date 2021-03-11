class MedicalFormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.doctor || user.profile_type == "Patient"
  end

  def show?
    doctor_or_admin? || patient_owner?
  end

  private

  def patient_owner?
    user == record.patient.user
  end
end
