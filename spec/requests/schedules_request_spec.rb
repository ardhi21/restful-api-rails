require 'rails_helper'

RSpec.describe "Schedules API", type: :request do
    # Initialize the test data
    let!(:doctor) { create(:doctor) }
    let!(:hospital) { create(:hospital) }
    let!(:schedules) { create_list(:schedule, 20, doctor_id: doctor.id, hospital_id: hospital.id)}
    let(:hospital_id) { hospital.id }
    let(:doctor_id) { doctor.id }
    let(:id) { schedules.first.id }

    # Test suite for GET /doctors/:doctor_id/schedules
    describe 'GET /doctors/:doctor_id/schedules' do
        before { get "/doctors/#{doctor_id}/schedules" }

        context 'when doctor exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all doctor shedules' do
                expect(json.size).to eq(20)
            end
        end

        context 'when doctor does not exist' do
            let(:doctor_id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Doctor/)
            end
        end
    end

    # Test suite for GET /doctors/:doctor_id/schedules/:schedule_id
    describe 'GET /doctors/:doctor_id/schedules/:schedule_id' do
        before { get "/doctors/#{doctor_id}/schedules/#{id}" }

        context 'when doctor schedule exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the schedule' do
                expect(json['id']).to eq(id)
            end
        end

        context 'when doctor schedule does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Schedule/)
            end
        end
    end

    # Test suite for POST /doctors/:doctor_id/schedules
    describe 'POST /doctors/:doctor_id/schedules' do
        let(:valid_attributes) { { hospital_id: hospital.id, date: '2020-10-28', start_time: '08:00:00', end_time: '10:00:00'  } }

        context 'when request attributes are valid' do
            before { post "/doctors/#{doctor_id}/schedules", params: valid_attributes }

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when an invalid request' do
            before { post "/doctors/#{doctor_id}/schedules", params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Hospital must exist, Date can't be blank, Start time can't be blank, End time can't be blank/)
            end
        end
    end

    # Test suite for PUT /doctors/:doctor_id/schedules/:schedule_id
    describe 'PUT /doctors/:doctor_id/schedules/:schedule_id' do
        let(:valid_attributes) { { doctor_id: '09:00:00' } }

        before { put "/doctors/#{doctor_id}/schedules/#{id}", params: valid_attributes }

        context 'when schedule exist' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end

            it 'update the record' do
                expect(response.body).to be_empty
            end
        end

        context 'when the schedule does not exist' do
            let(:id) { 0 }
            
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Schedule/)
            end
        end
    end

    # Test suite for DELETE /schedules/:id
    describe 'DELETE /schedules/:id' do
        before { delete "/doctors/#{doctor_id}/schedules/#{id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
