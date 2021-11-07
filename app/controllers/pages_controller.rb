class PagesController < ApplicationController
  def home
  end

  def about
  end

  def history
    @History = History.all
  end
end
