require 'rails_helper'

RSpec.describe 'Api::V1::ReviewsControllers', type: :request do
  describe 'POST #create' do
    describe 'success' do
      before do
        airline = Airline.new(name: 'fake airline')
        airline.save
        headers = { 'Content-Type' => 'application/json' }
        post '/api/v1/reviews', params: { title: 'Great airline', score: 5, airline_id: airline.id }.to_json, headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['title']).to eq('Great airline')
        expect(json_response['data']['attributes']['description']).to eq(nil)
        expect(json_response['data']['attributes']['score']).to eq(5)
      end
    end

    describe 'failed' do
      before do
        airline = Airline.new(name: 'fake airline')
        airline.save
        headers = { 'Content-Type' => 'application/json' }
        post '/api/v1/reviews', params: { description: 'I had a usual experience', score: 3, airline_id: airline.id }.to_json, headers: headers
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'DELETE #destroy' do
    describe 'success' do
      before do
        airline = Airline.new(name: 'fake airline')
        airline.save
        review = Review.new(title: 'Awesome', score: 5, airline_id: airline.id)
        review.save
        headers = { 'Content-Type' => 'application/json' }
        delete "/api/v1/reviews/#{review.id}", headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'failed' do
      before do
        non_existant_id = 20
        headers = { 'Content-Type' => 'application/json' }
        delete "/api/v1/reviews/#{non_existant_id}", headers: headers
      end

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(422)
      end

    end
  end
end
