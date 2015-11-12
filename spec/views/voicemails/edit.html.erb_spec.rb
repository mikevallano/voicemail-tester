require 'rails_helper'

RSpec.describe "voicemails/edit", type: :view do
  before(:each) do
    @voicemail = assign(:voicemail, Voicemail.create!(
      :url => "MyString"
    ))
  end

  it "renders the edit voicemail form" do
    render

    assert_select "form[action=?][method=?]", voicemail_path(@voicemail), "post" do

      assert_select "input#voicemail_url[name=?]", "voicemail[url]"
    end
  end
end
