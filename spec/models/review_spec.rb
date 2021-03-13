require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validation' do
    let(:airline) { Airline.new(name: 'fake airline') }
    before { airline.save }

    it 'ensures title presense' do
      review = Review.new(description: 'I had a lovely time', score: 5, airline_id: airline.id)

      expect(review.save).to eq(false)
    end

    it 'ensures score presense' do
      review = Review.new(title: 'Wow!', description: 'I had a lovely time', airline_id: airline.id)

      expect(review.save).to eq(false)
    end

    it 'ensures airline_id presense' do
      review = Review.new(title: 'Wow!', description: 'I had a lovely time', score: airline.id)

      expect(review.save).to eq(false)
    end

    it 'allows no description presence' do
      review = Review.new(title: 'Wow!', score: 5, airline_id: airline.id)

      expect(review.save).to eq(true)
    end
  end
end
