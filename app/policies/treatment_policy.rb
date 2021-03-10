class TreatmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    doctor_or_admin?
  end

  def create?
    doctor?
  end

  def update?
    doctor?
  end

  def destroy?
    doctor?
  end

  private

  def doctor?
    user.doctor
  end
end
