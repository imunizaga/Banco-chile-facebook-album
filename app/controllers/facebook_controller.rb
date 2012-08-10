class FacebookController < ApplicationController
  def login
    if session[:callback_return]  != nil
      redirect = session[:callback_return]
      session[:callback_return] = nil
      redirect_to redirect and return
    end
    if session[:access_token] == nil or session['id'] == nil
      session[:return] = '/'
      redirect_to '/auth/facebook' and return
    end
    print session[:access_token]
    @api = Koala::Facebook::API.new(session[:access_token])
    begin
      @user = @api.get_object("me")
      @user['img'] = 'https://graph.facebook.com/' + @user['id'] + '/picture?type=square'
    rescue Exception=>ex
      session[:access_token] = nil
      session[:id] = nil
      session[:return] = '/'
      redirect_to '/auth/facebook' and return
    end
    redirect_to '/auth/facebook' and return
  end
end
