class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    if params.include?(:offset)
      @users = User.ranking(params[:offset].to_i)
    else
      @users = User.ranking()
    end

    respond_to do |format|
      format.json { render json: @users }
    end
  end
end
