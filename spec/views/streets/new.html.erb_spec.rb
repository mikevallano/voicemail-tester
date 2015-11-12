require 'rails_helper'

RSpec.describe "streets/new", type: :view do
  before(:each) do
    assign(:street, Street.new(
      :name => "MyString",
      :image => "MyString"
    ))
  end

  it "renders new street form" do
    render

    assert_select "form[action=?][method=?]", streets_path, "post" do

      assert_select "input#street_name[name=?]", "street[name]"

      assert_select "input#street_image[name=?]", "street[image]"
    end
  end
end
