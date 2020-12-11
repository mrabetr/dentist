class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      if doctor_or_admin?
        scope.all
      else
        scope.where(patient: user.profile)
      end
    end
  end

  def show?
    doctor_admin_or_patient_owner?
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

  # def doctor_or_admin?
  #   user.doctor || user.admin
  # end

  def doctor_admin_or_patient_owner?
    user.doctor || user.admin || user == record.patient.user
  end
end
