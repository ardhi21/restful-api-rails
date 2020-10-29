class SchedulesController < ApplicationController
    before_action :set_doctor
    before_action :set_doctor_schedule, only: [:show, :update, :destroy]

    # GET /doctors/:doctor_id/schedules
    def index
        json_response(@doctor.schedules) 
    end

    # GET /doctors/:doctor_id/schedules/:id
    def show
        json_response(@schedule) 
    end

    # POST /doctors/:doctor_id/schedules
    def create
        data_params = params.permit(:hospital_id, :date, :start_time, :end_time)
        @doctor.schedules.create!(data_params) 
        json_response(@doctor, :created)
    end

    # PUT /doctors/:doctor_id/schedules/:id
    def update
        @schedule.update(item_params) 
        head :no_content
    end

    # DELETE /doctors/:doctor_id/schedules/:schedule_id
    def destroy
        @schedule.destroy
        head :no_content 
    end

    private

    def item_params
        params.permit(:date, :start_time, :end_time)
    end

    def set_doctor
        @doctor = Doctor.find(params[:doctor_id]) 
    end

    def set_hospital
        @hospital = Hospital.find(params[:hospital_id])
    end

    def set_doctor_schedule
        @schedule = @doctor.schedules.find_by!(id: params[:id])  if @doctor
    end
end
