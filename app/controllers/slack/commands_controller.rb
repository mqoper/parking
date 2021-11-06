require 'openssl'
require 'active_support/security_utils'

class Slack::CommandsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_slack_request

  def create
    json = { text: "You reserved spot #{params[:text]}"}

    render json: json
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