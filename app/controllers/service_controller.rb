class ServiceController < ApplicationController

  def agent
    @customer = Customer.first
    capability = Twilio::Util::Capability.new(ENV["twilio_account_sid"], ENV["twilio_auth_token"])
    capability.allow_client_outgoing(ENV["twilio_twiml_app_sid"])
    @token = capability.generate()
  end

  def streetsign
    @street = Street.first
    capability = Twilio::Util::Capability.new(ENV["twilio_street_account_sid"], ENV["twilio_auth_token"])
    capability.allow_client_outgoing(ENV["twilio_street_account_sid"])
    @token = capability.generate()
  end
end
