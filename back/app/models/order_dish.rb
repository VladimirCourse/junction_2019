class OrderDish
    include Mongoid::Document

    field :name, type: String
  
    field :calories, type: Integer
    field :proteins, type: Integer
    field :fats, type: Integer
    field :carbohydrates, type: Integer
    field :price, type: Integer
    field :count, type: Integer
    field :sale, type: Float
    field :sale_price, type: Integer

    validates :count, inclusion: 1..10

    belongs_to :order
    belongs_to :dish

end
  