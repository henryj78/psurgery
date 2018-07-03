Rails.application.routes.draw do
  resources :customers do
    get   'customer_county'
    get   'customer_device'
    get   'add_county'
    get   'validate'
    get   'deactivate'
    post  'update_county'
    patch 'deativate_note'
  end

  resources :zipcodes do
    get 'customer'
  end
  root "zipcodes#customer"
end
