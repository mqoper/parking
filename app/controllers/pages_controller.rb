class PagesController < ApplicationController

  def home
    redirect_to pages_history_path if logged_in?
    @current_user = current_user
  end

  def about
  end

  def history
    @histories = History.all.paginate(page: params[:page], per_page: 20)
    @spots = Spot.all
    @spot = @histories.distinct.pluck(:spot_id)
  end

  # def create
  #   @history = History.new(history_params)
  #   @history = current_user
  #   if @history.save
  #     flash[:notice] = "Parking spot has been reserved by"
  #   end
  # end
  #
  # def history_params
  #   params.require(:history).permit(:user_id, :spot_id)
  # end
  #


end
