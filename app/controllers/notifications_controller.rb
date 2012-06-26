class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all

    respond_to do |format|
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.json { render json: @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    @notification = Notification.new

    respond_to do |format|
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])
    @user=User.find(session['id'])
    @notification['sender_id'] = @user.id
    @notification['status'] = 0
    respond_to do |format|
      if @notification.save
        format.json { render json: @notification, status: :created, location: @notification }
        if @notification.challenge_id != nil
          CardPack.create(challenge_id: @notification.challenge_id, user_id: @user.id)
        end
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1.json
  def update
    # one can only modify the status
    @notification = Notification.find(params[:id])
    @user=User.find(session['id'])
    respond_to do |format|
      if @notification['status'] == 1
        format.json { head :no_content }
      elsif @notification['user_id'] != session['id']
        format.json { head :no_content }
      else params[:status] == 1 and @notification['status'] == 0
        @notification.update_attributes(:status=>params[:notification][:status])
        format.json { head :no_content }
        if @notification.challenge_id == nil
          @user.trade_card(@notification.sender_id, @notification.cards_in, 
            @notification.cards_out) 
        end
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
