class ApplicationController < ActionController::Base
 protect_from_forgery with: :exception
 before_action :authenticate_user!, :except => [:customer, :create, :aws_hits ]

 # alternative to overriding exceptions
 rescue_from "Exception", with: :forbidden

 private

 def forbidden(exception)
  render text: exception.message
 end
end
