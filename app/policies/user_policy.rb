class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless provider_or_admin?

      scope.all
    end
  end

  def index?
    admin?
  end

  def clients?
    provider_or_admin?
  end

  def create?
    provider_or_admin?
  end

  def update?
    provider_or_admin?
  end

  def impersonate?
    admin?
  end

  def stop_impersonating?
    true
  end

  def provider?
    user.provider
  end

  def client?
    user.profile_type == "Client"
  end

  private

  def admin?
    user.admin
  end
end
