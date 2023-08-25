class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless provider_or_admin?

      scope.all
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def index?
    provider_or_admin?
  end

  def show?
    provider_or_admin?
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
    user == record.provider.user
  end
end
