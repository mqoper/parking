class PagesController < ApplicationController
  def home
  end

  def about
  end

  def history
    @histories = History.all.paginate(page: params[:page], per_page: 10)
  end
end
