class Place
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :score, type: Float
  field :lat, type: Float
  field :lng, type: Float
  field :distance, type: Integer
  field :address, type: String
  field :phone, type: String
  field :category, type: String
  field :cuisines, type: Array, default: []
  field :restrictions, type: Array, default: []

  validates :name, length: {minimum: 1, maximum: 64}, presence: true
  validates :description, length: {minimum: 1, maximum: 2048}, presence: true
  validates :address, length: {minimum: 1, maximum: 256}, presence: true
  validates :phone, length: {minimum: 0, maximum: 16}, allow_nil: true
  validates :lat, presence: true
  validates :lng, presence: true

  belongs_to :image
  
  has_many :dishes

  def as_json(options={})
    attrs = super
    
    attrs[:dishes] = dishes

    return attrs
  end
end
