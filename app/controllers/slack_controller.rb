class SlackController < ApplicationController
  def index
  end

  def new
    redirect_to ("https://slack.com/oauth/authorize\?scope\=chat:write:bot\&client_id\=" + "2694475882850.2707181232417")
  end

  def auth
    auth_result = Slack.oauth_access({client_id: "2694475882850.2707181232417", client_secret: "a8f6374435f3f96f6efe4bac5f216c89", code: params[:code], scope: "chat:write:bot"})

    if auth_result["ok"]
      redirect_to slack_index_path, notice: "test"
    else
      redirect_to slack_index_path, alert: "error: " + auth_result["error"]
    end
  end
end