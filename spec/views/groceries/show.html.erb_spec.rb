require 'rails_helper'

RSpec.describe "groceries/show", type: :view do
  before(:each) do
    @grocery = assign(:grocery, Grocery.create!(
      author: nil,
      name: "Name",
      amount: "9.99",
      unit: "Unit"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Unit/)
  end
end
