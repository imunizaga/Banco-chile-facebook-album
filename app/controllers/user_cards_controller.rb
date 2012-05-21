class UserCardsController < ApplicationController
  # GET /user_cards
  # GET /user_cards.json
  def index
    @user_cards = UserCard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_cards }
    end
  end

  # GET /user_cards/1
  # GET /user_cards/1.json
  def show
    @user_card = UserCard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_card }
    end
  end

  # GET /user_cards/new
  # GET /user_cards/new.json
  def new
    @user_card = UserCard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_card }
    end
  end

  # GET /user_cards/1/edit
  def edit
    @user_card = UserCard.find(params[:id])
  end

  # POST /user_cards
  # POST /user_cards.json
  def create
    @user_card = UserCard.new(params[:user_card])

    respond_to do |format|
      if @user_card.save
        format.html { redirect_to @user_card, notice: 'User card was successfully created.' }
        format.json { render json: @user_card, status: :created, location: @user_card }
      else
        format.html { render action: "new" }
        format.json { render json: @user_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_cards/1
  # PUT /user_cards/1.json
  def update
    @user_card = UserCard.find(params[:id])

    respond_to do |format|
      if @user_card.update_attributes(params[:user_card])
        format.html { redirect_to @user_card, notice: 'User card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_cards/1
  # DELETE /user_cards/1.json
  def destroy
    @user_card = UserCard.find(params[:id])
    @user_card.destroy

    respond_to do |format|
      format.html { redirect_to user_cards_url }
      format.json { head :no_content }
    end
  end
end
