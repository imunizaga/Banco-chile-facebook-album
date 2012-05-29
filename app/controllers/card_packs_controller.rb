class CardPacksController < ApplicationController
  # GET /card_packs
  # GET /card_packs.json
  def index
    @card_packs = CardPack.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @card_packs }
    end
  end

  # GET /card_packs/1
  # GET /card_packs/1.json
  def show
    @card_pack = CardPack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card_pack }
    end
  end

  # GET /card_packs/new
  # GET /card_packs/new.json
  def new
    @card_pack = CardPack.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card_pack }
    end
  end

  # GET /card_packs/1/edit
  def edit
    @card_pack = CardPack.find(params[:id])
  end

  # POST /card_packs
  # POST /card_packs.json
  def create
    @card_pack = CardPack.new(params[:card_pack])

    if @card_pack.challenge != nil
      @card_pack.challenge.n_cards.times do 
        @user_card = UserCard.create(:user_id=>session['id'], :card_pack_id=>@card_pack.id)
        #if @user_card.save == nil
        #  format.html { render action: "new" }
        #  format.json { render json: @card_pack.errors, status: :unprocessable_entity }
        #end
      end
    end
    respond_to do |format|
      if @card_pack.save
        format.html { redirect_to @card_pack, notice: 'Card pack was successfully created.' }
        format.json { render json: @card_pack, status: :created, location: @card_pack }
      else
        format.html { render action: "new" }
        format.json { render json: @card_pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /card_packs/1
  # PUT /card_packs/1.json
  def update
    @card_pack = CardPack.find(params[:id])

    respond_to do |format|
      if @card_pack.update_attributes(params[:card_pack].except(:id, :created_at, :updated_at))
        format.html { redirect_to @card_pack, notice: 'Card pack was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card_pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_packs/1
  # DELETE /card_packs/1.json
  def destroy
    @card_pack = CardPack.find(params[:id])
    @card_pack.destroy

    respond_to do |format|
      format.html { redirect_to card_packs_url }
      format.json { head :no_content }
    end
  end
end
