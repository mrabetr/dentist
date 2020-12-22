class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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
    user == record.booking.doctor.user
  end
end
