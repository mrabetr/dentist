class TreatmentsController < ApplicationController
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

  def treatment_params
    params.require(:treatment).permit(:name, :recommendations, :discussion, :patient_id,
                  procedures_attributes: [:id, :procedure, :justification, :price, :_destroy])
  end
end
