class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :links]

  def home
  end
end
