require 'rails_helper'

RSpec.describe "Doctors API", type: :request do
    # Initialize test data
    let!(:doctors) { create_list(:doctor, 10) }
    let(:doctor_id) { doctors.first.id }

    # Test suite for GET /docters
    describe 'GET /doctors' do
        # Make HTTP get request before each example
        before { get '/doctors' }

        it 'returns doctors' do
            # Note `json` is a custom helper to parse JSON responses
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /doctors/:id
    describe 'GET /doctors/:id' do
        before { get "/doctors/#{doctor_id}" }

        context 'when the record exists' do
            it 'returns the doctor' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(doctor_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:doctor_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Doctor/)
            end
        end
    end

    # Test suite for POST /doctors
    describe 'POST /doctors' do 
        # valid payload 
        let(:valid_attributes) { { name: 'John Doe', email: 'john@doe.com', address: 'lorem ipsum dolor sit', phone: '628123456789' } }

        context 'when the request is valid' do
            before { post "/doctors", params: valid_attributes }

            it 'creates a doctor' do
                expect(json['name']).to eq('John Doe')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before { post '/doctors', params: { name: 'Foobar', email: 'john@doe.com', address: 'lorem ipsum dolor sit' } }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Phone can't be blank/)
            end
        end
    end

    # Test suite for PUT /doctors/:id
    describe 'PUT /doctors/:id' do
        let(:valid_attributes) { { name: 'Jane Doe' } }

        context 'when the record exists' do 
            before { put "/doctors/#{doctor_id}", params: valid_attributes }

            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /doctors/:id
    describe 'DELETE /doctors/:id' do
        before { delete "/doctors/#{doctor_id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
