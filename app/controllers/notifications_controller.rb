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
      valid = @user.trade_card(@notification.sender_id, @notification.cards_in,
                               @notification.cards_out)
      reason = "Can't make trade"
    elsif @notification.challenge_id != nil
      print "SUPER CHALLENGE"
    end

    respond_to do |format|
      if valid
        # update the status
        #@notification.update_attributes(:status=>new_status)
        format.json { head :no_content }
      else
        # responde a bad request
        format.json { head :bad_request }
        print reason
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
