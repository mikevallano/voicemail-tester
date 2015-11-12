require 'rails_helper'

RSpec.describe "voicemails/show", type: :view do
  before(:each) do
    @voicemail = assign(:voicemail, Voicemail.create!(
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Url/)
  end
end
