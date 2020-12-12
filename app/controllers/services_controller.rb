class ServicesController < ApplicationController
  before_action :find_service, only: [:show, :edit, :update, :destroy]

  def index
    # @services = Service.all
    @services = policy_scope(Service).order(name: :asc)
  end

  def show
    # @service = Service.find(params[:id])
    # authorize @service
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    @service.doctor = current_user.profile
    authorize @service

    if @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def edit
    # @service = Service.find(params[:id])
  end

  def update
    # @service = Service.find(params[:id])

    if @service.update(service_params)
      redirect_to service_path(@service)
    else
      render :edit
    end
  end

  def destroy
    # @service = Service.find(params[:id])
    @service.destroy

    redirect_to services_path
  end

  private

  def find_service
    @service = Service.find(params[:id])
    authorize @service
  end

  def service_params
    params.require(:service).permit(:name, :description)
  end
end
