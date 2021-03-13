class ReviewSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :score, :airline_id

  belongs_to :airline
end
