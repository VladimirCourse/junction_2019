class Order
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :calories, type: Integer
    field :proteins, type: Integer
    field :fats, type: Integer
    field :carbohydrates, type: Integer
    field :price, type: Integer
    field :table, type: String
    field :serve_at, type: DateTime
    field :sale_price, type: Integer

    field :purchase_status, type: String
    field :take_status, type: String
    field :ready_status, type: String
    field :take_option, type: String

    belongs_to :place
    
    has_many :order_dishes

    def as_json(options={})
        attrs = super
        
        attrs[:order_dishes] = order_dishes
        attrs[:place] = place

        return attrs
      end 
  end
  