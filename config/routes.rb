Rails.application.routes.draw do
  resources :sale_payments
  devise_for :users

  resources :sales do
    get 'customer_sales'
  end

  resources :tracks

  resources :payments do
    get 'retrieve_pay'
    get   'add_payment'
  end

  resources :customers do
    get   'customer_county'
    get   'customer_device'
    get   'add_county'
    get   'validate'
    get   'hold_validate'
    get   'deactivate'
    post  'update_county'
    patch 'deativate_note'
    get   'remove_zone_id'
    get   'report_status'
  end

  resources :zipcodes do
    get 'customer'
    get 'aws_hits'
  end

  get "/location" => "application#location"
  root "zipcodes#customer"
end
