class OmniauthCallbacksController < ApplicationController
  def slack
    render plain: "Success!"
  end
end