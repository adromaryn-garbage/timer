class TimeZonesController < ApplicationController
  before_action :authenticate_user!
  def edit
    @user=current_user
  end

  def update
    puts "Параметры #{params} вот так"
    user=current_user
    user.timezone=get_timezone_param
    respond_to do |format|
      if user.save
        flash[:success] = 'Timezone was successfully updated.'
        format.html { redirect_to root_path }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
    
    def get_timezone_param
      (params.require(:user).permit(:timezone))[:timezone]
    end
end
