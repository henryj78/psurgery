Rails.application.routes.draw do
  resources :customers do
    get   'customer_county'
    get   'customer_device'
    get   'add_county'
    get   'validate'
    get   'deactivate'
    post  'update_county'
    patch 'deativate_note'
    get   'remove_zone_id'
  end

  resources :zipcodes do
    get 'customer'
  end

  get "/location" => "application#location"
  root "zipcodes#customer"
end
