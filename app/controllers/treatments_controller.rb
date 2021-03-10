class TreatmentsController < ApplicationController
  before_action :find_treatment, only: [:show, :edit, :update, :destroy]

  def show
    @total = @treatment.procedures.sum(:price_cents) / 100.0
  end

  def new
    @treatment = Treatment.new
    @treatment.procedures.build
    authorize @treatment
  end

  def create
    @treatment = Treatment.new(treatment_params)
    authorize @treatment

    if @treatment.save
      patient = @treatment.patient
      redirect_to patient_path(patient)
    else
      render :new
    end
  end

  private

  def find_treatment
    @treatment = Treatment.find(params[:id])
    authorize @treatment
  end

  def treatment_params
    params.require(:treatment).permit(:name, :recommendations, :discussion, :patient_id,
                  procedures_attributes: [:id, :procedure, :justification, :price, :_destroy])
  end
end
