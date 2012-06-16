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
    user=User.find(session['id'])
    @notification['sender_id'] = user.id

    respond_to do |format|
      if @notification.save
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1.json
  def update
    # one can only modify the status
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification['status']
        format.json { head :no_content }
      elsif @notification['user_id'] == session['id']
        format.json { head :no_content }
      else params[:status]
        #here goes the trade logic if corresponds
        @notification.update_attributes(params[:notification].only(:status))
        format.json { head :no_content }
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
