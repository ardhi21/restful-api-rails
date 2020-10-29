require 'rails_helper'

RSpec.describe "Hospitals API", type: :request do
    # Initialize test data
    let!(:hospitals) { create_list(:hospital, 10) }
    let(:hospital_id) { hospitals.first.id }

    # Test suite for GET /hospitals
    describe 'GET /hospitals' do
        # Make HTTP get request before each example
        before { get '/hospitals' }

        it 'returns hospitals' do
            # Note `json` is a custom helper to parse JSON responses
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /hospitals/:id
    describe 'GET /hospitals/:id' do
        before { get "/hospitals/#{hospital_id}" }

        context 'when the record exists' do
            it 'returns the hospital' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(hospital_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:hospital_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Hospital/)
            end
        end
    end

    # Test suite for POST /hospitals
    describe 'POST /hospitals' do
        # valid payload
        let (:valid_attributes) {{name: 'Health House', address: 'Lorem ipsum', phone: '62813456789', location: '+23242323, -1233323'}}

        context 'when the request is valid' do
            before { post "/hospitals", params: valid_attributes }

            it 'creates a doctor' do
                expect(json['name']).to eq('Health House')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post "/hospitals", params: { address: 'Lorem ipsum', phone: '62813456789', location: '+23242323, -1233323'}}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Name can't be blank/)
            end
        end
    end

    # Test suite for PUT /hospitals/:id
    describe 'PUT /hospitals/:id' do
        let(:valid_attributes) { { name: 'Very Health House' } }

        context 'when the record exists' do
            before { put "/hospitals/#{hospital_id}", params: valid_attributes }

            it 'update the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /hospitals/:id
    describe 'DELETE /hospitals/:id' do
        before { delete "/hospitals/#{hospital_id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
