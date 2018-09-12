class CdropsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
     @cap_string = params[:term].slice(0,1).capitalize + params[:term].slice(1..-1)
     if @cap_string.size > 1
       @cap_string = @cap_string.titleize
       @cites = Zipcode.order(:city).where("city like ?", "%#{@cap_string}%")
     else
        @cites = []
     end
     # render json: @cites.map(&:city).uniq
     render json: @cites.map{|n| "#{n.city} ,  #{n.state}"}.uniq
  end
end
