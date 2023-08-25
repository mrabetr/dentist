class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    provider?
  end

  def update?
    provider_owner?
  end

  def destroy?
    provider_owner?
  end

  private

  def provider?
    user.provider
  end

  def provider_owner?
    user == record.booking.provider.user
  end
end
