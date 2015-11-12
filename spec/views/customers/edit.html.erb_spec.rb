require 'rails_helper'

RSpec.describe "customers/edit", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
      :firstname => "MyString",
      :lastname => "MyString",
      :city => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit customer form" do
    render

    assert_select "form[action=?][method=?]", customer_path(@customer), "post" do

      assert_select "input#customer_firstname[name=?]", "customer[firstname]"

      assert_select "input#customer_lastname[name=?]", "customer[lastname]"

      assert_select "input#customer_city[name=?]", "customer[city]"

      assert_select "input#customer_state[name=?]", "customer[state]"
    end
  end
end
