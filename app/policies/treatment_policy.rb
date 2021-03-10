class TreatmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    doctor?
  end

  private

  def doctor?
    user.doctor
  end
end
