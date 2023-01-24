class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.all
      if doctor_or_admin?
        scope.all
      else
        scope.where(patient: user.profile)
      end
    end
  end

  def index?
    doctor_or_admin?
  end

  def show?
    doctor_admin_or_patient_owner?
  end

  def create?
    # update to true when ready to allow patient to add a new booking
    doctor?
  end

  def new_booking?
    new?
  end

  def update?
    doctor_owner?
  end

  def update_booking?
    update?
  end

  def update_amount?
    update?
  end

  def destroy?
    doctor_owner?
  end

  def send_sms_reminder?
    doctor?
  end

  def send_sms_confirmation?
    doctor?
  end

  private

  def doctor?
    user.doctor
  end

  def doctor_owner?
    user == record.doctor.user
  end

  def doctor_admin_or_patient_owner?
    user.doctor || user.admin || user == record.patient.user
  end
end
