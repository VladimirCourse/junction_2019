class OrdersController < ApplicationController

    # GET /orders
    def index
        render json: Order.all
    end

    # POST /orders
    def create
        order = Order.new(orders_params)
        order.purchase_status = :pending
        order.take_status = :waiting
        order.ready_status = :cooking
        order.price = 0
        order.sale_price = 0
        order.calories = 0
        order.fats = 0
        order.proteins = 0
        order.carbohydrates = 0

        if params[:order_dishes]
            params[:order_dishes].each do |param|
                dish = Dish.find(param[:dish_id])
                order.price += dish.price * param[:count]
                order.sale_price += dish.sale_price * param[:count]
                order.calories += dish.calories * param[:count]
                order.fats += dish.fats * param[:count]
                order.proteins += dish.proteins * param[:count]
                order.carbohydrates += dish.carbohydrates * param[:count]
            end
        end
        if order.save
            if params[:order_dishes]
                params[:order_dishes].each do |param|
                    dish = Dish.find(param[:dish_id])
                    ord = order.order_dishes.create(
                        dish_id: dish.id,
                        name: dish.name,
                        price: dish.price,
                        sale_price: dish.sale_price,
                        calories: dish.calories,
                        fats: dish.fats,
                        proteins: dish.proteins,
                        carbohydrates: dish.carbohydrates,
                        count: param[:count]
                    )
                    ord.save
                end
            end
            render json: order
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    private
    
        def orders_params
            params.permit(:comment, :table, :tips, :take_option, :place_id, :serve_at)
        end

        def dish_params(param)
            param.permit(:dish_id, :count)
        end
end
