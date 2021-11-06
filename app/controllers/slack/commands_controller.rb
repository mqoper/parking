require 'openssl'
require 'active_support/security_utils'

class Slack::CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_slack_request

  def create
    spot = Spot.find_by(name: "#{params[:text]}")
    if(!spot)
      json = {text: "Given spot doesn't exist"}
    elsif (spot.reserved == true)
      json = {text: "Spot #{spot.name} is currently reserved"}
    else
      spot.reserved = true
      spot.save
      json = {text: "You reserved spot #{spot.name}"}
    end

    render json: json

    # @spot.id(:text).save

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

    if !ActiveSupport::SecurityUtils.secure_compare(signature, slack_signature)
      head :unauthorized
    end
  end
end