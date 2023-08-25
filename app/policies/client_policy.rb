class ClientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, 'not allowed to view this page' unless provider_or_admin?

      scope.all
    end
  end

  def show?
    provider_or_admin?
  end

  def update?
    provider_or_admin?
  end

  def destroy?
    provider_or_admin?
  end

  def destroy_image?
    provider_or_admin?
  end

  def send_password_email?
    provider_or_admin?
  end

  def send_sms_routine_reminder?
    provider?
  end

  private

  def provider?
    user.provider
  end
end
