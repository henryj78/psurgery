class ApplicationController < ActionController::Base
 protect_from_forgery with: :exception
 before_action :authenticate_user!, :except => [:customer, :create, :aws_hits]
end
