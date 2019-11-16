Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/adminsdflsdfljhdl', as: 'rails_admin'

  get 'places', action: :index, controller: 'places'
  
  get 'images/:id', action: :show, controller: 'images'

  get 'orders', action: :index, controller: 'orders'
  post 'orders', action: :create, controller: 'orders'

  get 'recommendations', action: :index, controller: 'recommendations'
end
