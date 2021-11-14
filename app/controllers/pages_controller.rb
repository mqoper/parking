class PagesController < ApplicationController

  def home
    redirect_to pages_history_path if logged_in?
    @current_user = current_user
  end

  def about
  end

  def history
    @histories = History.all.paginate(page: params[:page], per_page: 20).order(id: :desc)
  end

end
