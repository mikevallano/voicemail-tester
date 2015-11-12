require 'rails_helper'

RSpec.describe "voicemails/index", type: :view do
  before(:each) do
    assign(:voicemails, [
      Voicemail.create!(
        :url => "Url"
      ),
      Voicemail.create!(
        :url => "Url"
      )
    ])
  end

  it "renders a list of voicemails" do
    render
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
