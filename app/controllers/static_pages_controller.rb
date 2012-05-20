class StaticPagesController < ApplicationController
  def home
    # auth established, now do a graph call:
          
    @api = Koala::Facebook::API.new(session[:access_token])
    begin
      @graph_data = @api.get_object("/me/statuses", "fields"=>"message")
      rescue Exception=>ex
      puts ex.message
    end
   puts session[:access_token]  + " << access"  
  end

  def help
  end
end
