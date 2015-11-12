require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
      :firstname => "Firstname",
      :lastname => "Lastname",
      :city => "City",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
  end
end
