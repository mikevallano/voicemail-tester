require 'rails_helper'

RSpec.describe "streets/index", type: :view do
  before(:each) do
    assign(:streets, [
      Street.create!(
        :name => "Name",
        :image => "Image"
      ),
      Street.create!(
        :name => "Name",
        :image => "Image"
      )
    ])
  end

  it "renders a list of streets" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
