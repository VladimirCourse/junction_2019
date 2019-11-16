class Dish
    include Mongoid::Document
    field :name, type: String
    field :description, type: String
    field :components, type: String
    field :score, type: Float
    field :calories, type: Integer
    field :proteins, type: Integer
    field :fats, type: Integer
    field :carbohydrates, type: Integer
    field :price, type: Integer
    field :sale_price, type: Integer
    field :categories, type: Array, default: []
    field :cuisines, type: Array, default: []
    field :restrictions, type: Array, default: []

    validates :name, length: {minimum: 1, maximum: 64}, presence: true
    validates :description, length: {minimum: 1, maximum: 2048}, presence: true
    validates :description, length: {minimum: 1, maximum: 2048}, presence: true
    validates :components, length: {minimum: 1, maximum: 2048}, presence: true    
    validates :calories, inclusion: 0..100000
    validates :proteins, inclusion: 0..100000
    validates :fats, inclusion: 0..100000
    validates :carbohydrates, inclusion: 0..100000
    validates :price, inclusion: 0..1000000

    belongs_to :image
    belongs_to :place

  end
  