require 'twilio-ruby'

class VoicemailsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def prompt
    response = Twilio::TwiML::Response.new do |r|
      r.Gather action: '/router', timeout: 5, numDigits: 1, finishOnKey: '' do
        r.Say "Yall from Tchopatulas? Enter the number of the sreet you want to pronounce.
          press 9 to listen to others' pronunciations.", :voice => 'alice'
        # r.Play asset_url('prompt.mp3')
      end
    end
    render_twiml response
  end

  def reprompt
    response = Twilio::TwiML::Response.new do |r|
      @last_street = Voicemail.last.street
      r.Gather action: "/rerouter?last_street_id=#{@last_street.id}", timeout: 5, numDigits: 1, finishOnKey: '' do
        r.Say "Press 1 to listen to others pronounce this street, or press 2 to pronounce another street.", :voice => 'alice'
        # r.Play asset_url('prompt.mp3')
      end
    end
    render_twiml response
  end


  def router
    response = Twilio::TwiML::Response.new do |r|
      @nums = ['1', '2', '3']
      if @nums.include?(params['Digits'])
        @street_id = params['Digits']
        r.Redirect(new_voicemail_path(:street_id => @street_id), method: 'GET')
      elsif params['Digits'] == '9'
        r.Redirect(random_voicemail_path, method: 'GET')
      else
        r.Redirect('/prompt', method: 'GET')
      end
    end
    render_twiml response
  end

  def rerouter
    response = Twilio::TwiML::Response.new do |r|
      if params['Digits'] == '1'
        @last_street_id = params['last_street_id']
        r.Redirect("/random?last_street_id=#{@last_street_id}"), method: 'GET')
      elsif params['Digits'] == '2'
        r.Redirect('/reprompt', method: 'GET')
      else
        r.Redirect('/reprompt', method: 'GET')
      end
    end
    render_twiml response
  end

  def new
    @street_id = params['street_id']
    puts "newparams: params, #{@street_id}"
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Leave a voice message after the beep. Press one when you are done recording.'
      r.Record action: "/voicemails?street_id=#{@street_id}", method: 'POST', maxLength: '60'
    end
    render_twiml response
  end

  def create
    @street_id = params['street_id']
    puts "params tunga on create: #{params}"
    puts "create street_id zibbler: #{@street_id}"
    if params['RecordingDuration'].to_i > 2
      @vm_saved = Voicemail.create(url: params['RecordingUrl'], street_id: @street_id)
      # @vm_saved.street_id = @street_id
    end
    puts "params after assigner on create: #{params}"

    response = Twilio::TwiML::Response.new do |r|
      if @vm_saved.present?
        r.Say 'Message saved.'
        r.Redirect('/prompt', method: 'GET')
      else
        r.Say "I'm sorry. That message was too short."
        r.Redirect(new_voicemail_path, method: 'GET')
      end
    end
    render_twiml response
  end

  def show
    @voicemail = Voicemail.find(params[:id])
    response = Twilio::TwiML::Response.new do |r|
      r.Play @voicemail.url
      r.Say "That was a good one. Here's another.", :voice => 'alice'
      r.Redirect(random_voicemail_path, method: 'GET')
    end
    render_twiml response
  end


  def random
    if params['last_street_id'].present?
      @street = Street.find(params['last_street_id'])
      @random_vm = Voicemail.by_street(@street).sample
      response = Twilio::TwiML::Response.new do |r|
       r.Redirect(("/voicemails/#{@random_vm.id}"), method: 'GET')
      end
    end

    @random_vm = Voicemail.all.sample

    response = Twilio::TwiML::Response.new do |r|
     r.Redirect(("/voicemails/#{@random_vm.id}"), method: 'GET')
    end
   render_twiml response
  end

  def render_twiml(response)
    render text: response.text
  end

  def post_params
    params.require(:voicemail).permit(:street_id)
  end

end
