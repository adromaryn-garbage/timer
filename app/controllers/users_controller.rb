class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  
  def show
    @user=current_user
    @events = @user.events.paginate(page: params[:page])
  end
end
