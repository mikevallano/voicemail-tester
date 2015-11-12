require 'rails_helper'

RSpec.describe "voicemails/new", type: :view do
  before(:each) do
    assign(:voicemail, Voicemail.new(
      :url => "MyString"
    ))
  end

  it "renders new voicemail form" do
    render

    assert_select "form[action=?][method=?]", voicemails_path, "post" do

      assert_select "input#voicemail_url[name=?]", "voicemail[url]"
    end
  end
end
