require 'twilio-ruby'

class TwilioController < ApplicationController

  after_action :set_header

  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Zorro is the chup. Do you like zorro? I like zorro, and I'm a robot.
      You must really love zorro. But alas, the turkey is cold.", :voice => 'alice'
    end

    render_twiml response
  end

  def set_header
    response.headers["Content-Type"] = "text/xml"
  end

  def render_twiml(response)
    render text: response.text
  end

  def connect_customer
    @customer = Customer.find(params[:id])

    response = Twilio::TwiML::Response.new do |r|
      r.Say "sweet. you are now calling #{@customer.firstname}.", :voice => 'alice'
      r.Dial :callerId => ENV["twilio_phone_number"] do |d|
        d.Number @customer.phone_number
      end
    end
    render_twiml response
  end

end