require 'twilio-ruby'

class VoicemailsController < ApplicationController

  skip_before_action :verify_authenticity_token

  # layout 'twilio_xml'

  def prompt
    response = Twilio::TwiML::Response.new do |r|
      r.Gather action: '/router', timeout: 5, numDigits: 1, finishOnKey: '' do
        r.Say "Yall from Tchopatulas? Press 1 to leave a voicemail pronouncing this street.
          press 2 to listed to others' pronunciations.", :voice => 'alice'
        # r.Play asset_url('prompt.mp3')
      end
    end
    render_twiml response
  end


  def router
    response = Twilio::TwiML::Response.new do |r|
      if params['Digits'] == '1'
      r.Redirect(new_voicemail_path, method: 'GET')
      elsif params['Digits'] == '2'
      r.Redirect(random_voicemail_path, method: 'GET')
      else
      r.Redirect('/prompt', method: 'GET')
      end
    end
    render_twiml response
  end

  def new
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Leave a voice message after the beep. Press one when you are done recording.'
      r.Record action: '/voicemail', method: 'POST', maxLength: '60'
    end
    render_twiml response
  end

  def create
    if params['RecordingDuration'].to_i > 2
      @vm_saved = Voicemail.create(url: params['RecordingUrl'])
    end

    response = Twilio::TwiML::Response.new do |r|
      if @vm_saved
        r.Say 'Message saved.'
        r.Redirect('/prompt', method: 'GET')
      else
        r.Say "I'm sorry. That message was too short."
        r.Redirect(new_voicemail_path, method: 'GET')
      end
    end
  end

  def show
    @voicemail = Voicemail.find(params[:id])
    response = Twilio::TwiML::Response.new do |r|
      r.Play @voicemail.url
      r.Say 'End of message. Playing another message.'
      r.Redirect(random_voicemail_path, method: 'GET')
    end
    render_twiml response
  end

  def random
    @random_vm = Voicemail.random
    response = Twilio::TwiML::Response.new do |r|
     r.Redirect(voicemail_path(@random_vm), method: 'GET')
    end
   render_twiml response
  end

  def render_twiml(response)
    render text: response.text
  end

end
