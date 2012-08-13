class StaticPagesController < ApplicationController
  def home
    @ranking = User.ranking
    @user = nil
    if session[:id] != nil
      @user = User.find_by_id(session[:id])
      if @user
        # add data to the user object
        @user.prepare_to_send session


        @cards = Card.all
        @challenges = Challenge.all_without_server_params(session)
        @user_challenges = UserChallenge.where(user_id:@user[:id])

        @user.fb_access_token = ""
        @user.tw_access_token = ""
      else
        session[:id] = nil
      end
    end

    # if the user was not found
    if @user == nil
      @user = {}

      # we now check weather we got a request
      @user[:request_ids] = params[:request_ids]
      request_id = params[:request_ids]
      if request_id
        session[:request_id] = request_id
      end

    end
  end

  def help
  end

end
