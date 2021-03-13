require 'rails_helper'

RSpec.describe 'Api::V1::AirlinesControllers', type: :request do
  describe 'GET #index' do
    before do
      Airline.new(name: 'fake airlines').save
      get '/api/v1/airlines'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response['data'][0]['attributes']['name']).to eq('fake airlines')
      expect(json_response['data'][0]['attributes']['slug']).to eq('fake-airlines')
    end
  end

  describe 'GET #show' do
    before do
      Airline.new(name: 'fake airlines').save
      get '/api/v1/airlines/fake-airlines'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['name']).to eq('fake airlines')
      expect(json_response['data']['attributes']['slug']).to eq('fake-airlines')
    end
  end

  describe 'POST #create' do
    describe 'success' do
      before do
        headers = { 'Content-Type' => 'application/json' }
        post '/api/v1/airlines', params: { name: 'fake airlines' }.to_json, headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['name']).to eq('fake airlines')
        expect(json_response['data']['attributes']['slug']).to eq('fake-airlines')
      end
    end

    describe 'failed' do
      before do
        headers = { 'Content-Type' => 'application/json' }
        post '/api/v1/airlines', params: { image_url: 'https://image_url.jpg' }.to_json, headers: headers
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'PUT/PATCH #update' do
    describe 'success' do
      before do
        Airline.new(name: 'fake airlines').save
        headers = { 'Content-Type' => 'application/json' }
        put '/api/v1/airlines/fake-airlines', params: { name: 'fantasy airlines', image_url: 'https://image_url.jpg' }.to_json, headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['name']).to eq('fantasy airlines')
        expect(json_response['data']['attributes']['slug']).to eq('fake-airlines')
      end
    end

    describe 'failed' do
      before do
        headers = { 'Content-Type' => 'application/json' }
        put '/api/v1/airlines/non-existant-airline', params: { image_url: 'https://image_url.jpg' }.to_json, headers: headers
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'DELETE #destroy' do
    describe 'success' do
      before do
        Airline.new(name: 'fake airlines').save
        headers = { 'Content-Type' => 'application/json' }
        delete '/api/v1/airlines/fake-airlines', headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'failed' do
      before do
        Airline.new(name: 'fake airlines').save
        headers = { 'Content-Type' => 'application/json' }
        delete '/api/v1/airlines/non-existant-airline', headers: headers
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(422)
      end

    end
  end
end
