class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new(ENV["twilio_account_sid"], ENV["twilio_auth_token"])
    message = client.messages.create from: '(870) 292-4764', to: '303.638.6305', body: 'String and chill?'
    render plain: message.status
  end
end
