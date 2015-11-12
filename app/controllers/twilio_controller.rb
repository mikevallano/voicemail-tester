require 'twilio-ruby'

class TwilioController < ApplicationController

  after_action :set_header

  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Zorro is the chup. Do you like zorro? I like zorro, and I'm a robot.
      You must really love zorro. But alas, the turkey is cold.", :voice => 'alice'
      r.Play "https://soundcloud.com/mikevallano/moontower"
    end

    render_twiml response
  end

  def set_header
    response.headers["Content-Type"] = "text/xml"
  end

  def render_twiml(response)
    render text: response.text
  end

end