class StaticPagesController < ApplicationController
  def home         
    if session[:callback_return]  != nil
        redirect=session[:callback_return]
        session[:callback_return] = nil
        redirect_to redirect and return
    end
    if session[:access_token] == nil or session['id'] == nil
      redirect_to '/auth/facebook' and return
    end
    @api = Koala::Facebook::API.new(session[:access_token])
    begin
      @user = @api.get_object("me")
      @user['img'] = 'https://graph.facebook.com/' + @user['id'] + '/picture?type=square'
      rescue Exception=>ex
      puts ex.message
    end
  end

  def help
  end

end
