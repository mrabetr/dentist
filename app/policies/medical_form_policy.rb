class MedicalFormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.profile_type == "Patient"
  end

  # private

  # def patient_owner?
  #   user == record.patient.user
  # end
end
