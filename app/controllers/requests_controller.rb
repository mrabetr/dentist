class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :find_request, only: [:show]

  def index
    @requests = policy_scope(Request).order(id: :desc)
  end

  def new
    @request = Request.new
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    authorize @request

    if @request.save
      redirect_to root_path, notice: 'Thanks for contacting us! We have received your request and we will contact you soonest.'
    else
      render :new
    end
  end

  def show; end

  private

  def find_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:first_name, :last_name, :email, :mobile, :comments)
  end
end
