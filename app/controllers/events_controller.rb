class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if @event.user_id != current_user.id
      redirect_to root_path
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    if @event.user_id != current_user.id
      redirect_to root_path
    end
  end

  # POST /events
  # POST /events.json
  def create
    ep=event_params
    @event = Event.new(ep)
    @event.user_id = current_user.id
    @user = User.new()
    @user=current_user
    @user.timezone ||= ep[:timezone]

    respond_to do |format|
      if @event.save && @user.save
      	flash[:success] = 'Event was successfully created.'
        format.html { redirect_to root_path }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if (set_event).user_id!=current_user.id
      redirect_to root_path
    else
      ep=event_params
      @user = User.new
      @user=current_user
      @user.timezone ||= ep.timezone
      respond_to do |format|
        if @event.update(ep) && @user.save
          flash[:success] = 'Event was successfully updated.'
          format.html { redirect_to @event }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if (set_event).user_id!= current_user.id
      redirect_to root_path
      puts"WoW!"
    else
        @event.destroy
        respond_to do |format|
         flash[:success] = 'Event was successfully destroyed.'
         format.html { redirect_to root_path }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:message, :time, :timezone, :phone_number)
    end
end
