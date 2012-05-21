class StaticPagesController < ApplicationController
  def home         
    @api = Koala::Facebook::API.new(session[:access_token])
    if session[:access_token]==nil
      redirect_to '/auth/facebook/'
    end
    begin
      @graph_data = @api.get_object("/me/statuses", "fields"=>"message")
      rescue Exception=>ex
      puts ex.message
    end
  end

  def help
  end

end
