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
    data = params[:notification].delete(:data)
    # instanciate the new notification
    @notification = Notification.new(params[:notification])

    # set the status of the notification as nil ("unread")
    @notification[:status] = nil

    #asume that the new notification is a valid one, and default empty reason
    #of why it could fail
    valid = true
    reason = ""

    # obtain the logged user
    @user=User.find(session['id'])

    # if the notification already sets a user then we asume it's a trade
    # So we set the logged user as the sender
    # Else, asume it's a challenge completed notification
    if @notification.user_id
      # this is a trade, so check if a user is not trading with himself
      if @notification.user_id == @user.id
        valid = false
      else
        # set trade values
        @notification[:sender_id] = @user.id
        @notification[:challenge_id] = nil

        trade = @notification.prepare_trade_proposal()
        valid = trade[:valid]
        reason = trade[:reason]
      end
    else
      # this is not a trade, thus it's a challenge completed notification
      if @notification.challenge_id == nil
        valid = false
      else
        # set challenge values values
        @notification[:user_id] = @user.id
        reason = @notification.validate_challenge(session, @user, data)
        valid = reason[:success]
        @notification[:sender_id] = nil
      end
    end

    if valid
      valid = @notification.save
    end

    respond_to do |format|
      if valid
        # if it's a challenge
        if @notification.challenge_id != nil
          card_pack = CardPack.create(challenge_id: @notification.challenge_id,
                                      user_id: @user.id)
          json_card_ids = ActiveSupport::JSON.encode(card_pack[:card_ids])
          @notification.cards_in = json_card_ids
          @notification.save
        else
          # it's a trade, lock out the card
          card_in = trade[:card_in]
          card_in[:locked] = true
          card_in.save
          @user.set_album
        end
        format.json {
          render json: @notification,
          status: :created,
          location: @notification
        }
      else
        format.json {
          render json: reason,
          status: :created
        }
      end
    end
  end

  # PUT /notifications/1.json
  # Public: Updates the Notification object.
  # One can only modify the status field from nil to 1(accepted) or 0
  # (rejected)
  def update
    # obtain the notification
    @notification = Notification.find(params[:id])
    # obtain the logged user
    @user = User.find(session['id'])

    new_status = params[:notification][:status]

    # asume that the notification update is valid
    valid = true
    #if the notification does not have a "unanswered" status
    if @notification['status'] != nil
      valid = false
      reason = "Notification is closed"
    # if the user trying to update the notification is not the logged user
    elsif @notification['user_id'] != session['id']
      valid = false
      reason = "Forbidden"
    # if the status we are updating to is not 0 or 1
    elsif new_status != 0 and new_status != 1
      valid = false
      reason = "Invalid status"
    # if it's a trade
    elsif @notification.sender_id != nil
      trade = @user.trade_card(@notification.sender_id, @notification.cards_in,
                               @notification.cards_out)
      valid = trade[:valid]
      reason = trade[:reason]
    elsif @notification.challenge_id != nil
      print "SUPER CHALLENGE"
    end

    respond_to do |format|
      if valid
        # update the status
        #@notification.update_attributes(:status=>new_status)
        @notification.destroy()
        format.json { head :no_content }
      else
        # responde a bad request
        format.json {
          render json: reason,
          status: :unprocessable_entity
        }
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
