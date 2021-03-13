require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'validation' do
    it 'ensures name presence' do
      airline = Airline.new(image_url: 'https://image_url.jpg')

      expect(airline.save).to eq(false)
    end

    it 'allows no image_url presence' do
      airline = Airline.new(name: 'fake airline')

      expect(airline.save).to eq(true)
    end
  end

  describe 'slug' do
    it 'ensures slug is slugified name' do
      airline = Airline.new(name: 'fake airline')
      airline.save
      expect(airline.slug).to eq('fake-airline')
    end
  end

  describe 'avg_score' do
    it 'should count avg_score correctly' do
      airline = Airline.new(name: 'fake airline')
      airline.save

      review1 = Review.new(title: 'Great airline', score: 5, airline_id: airline.id)
      review1.save

      review1 = Review.new(title: 'Bad airline', score: 1, airline_id: airline.id)
      review1.save

      expect(airline.avg_score).to eq(3)
    end
  end
end
