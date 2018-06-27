Rails.application.routes.draw do
  resources :customers
  resources :zipcodes do
    get 'customer'
  end
  root "zipcodes#customer"
end
