require 'openssl'
require 'active_support/security_utils'

class Slack::CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_slack_request

  def create
    spot = Spot.find_by(name: params[:text].to_s)          # Serch a spot in database by name
    users = User.all
    if !spot                                               # Chcecking a spot
      json = { text: "Selected spot doesn't exist" }       # Response to Slack
    elsif (spot.reserved == true)
      json = { text: "Spot #{spot.name} is currently reserved" }
    else
      spot.reserved = true                                 # Reserved a spot
      spot.save
      user = users.find_by(slack_id: params[:user_id])
      if !user.nil?
        history = History.new(user_id: user.id, spot_id: spot.id)
        history.save
        json = { text: "User #{user.full_name} reserved spot #{spot.name}" }
      else
        history = History.new(user_id: 0, spot_id: spot.id)
        history.save
        json = { text: "Unverified user reserved spot #{spot.name}" }
      end
    end

    render json: json
  end

  def register
    user = User.find_by(slack_register_id: params[:text].to_s)
    check = User.find_by(slack_id: params[:user_id])
    if !user
      json = { text: "This code doesn't exist in the database" }
    else
      # byebug
      if !check.nil?
        json = { text: 'This account is already registered' }
      else
        user.slack_id = params[:user_id]
        user.save
        json = { text: "The account has been registered with #{user.full_name}" }
      end
    end

    render json: json
  end

  def show
    spot = Spot.where(reserved: true).order(id: :asc)
    histories = History.all
    users = User.all
    message = "Reserved spots: \n"
    spot.each do |i|
      last_reserved = histories.where(spot_id: i.id).last.user_id
      message += " #{i.name} by #{users.find(last_reserved).full_name} \n"
    end
    render json: message
  end

  private

  def verify_slack_request
    timestamp = request.headers['X-Slack-Request-Timestamp']
    if (Time.now.to_i - timestamp.to_i).abs > 300
      head :unauthorized
      return
    end

    sig_basestring = "v0:#{timestamp}:#{request.raw_post}"
    signature = "v0=" + OpenSSL::HMAC.hexdigest("SHA256", "94369a6eeb2f66f62d5d5700a96c4730", sig_basestring)
    slack_signature = request.headers['X-Slack-Signature']

    if (!ActiveSupport::SecurityUtils.secure_compare(signature, slack_signature))
      head :unauthorized
    end
  end

end