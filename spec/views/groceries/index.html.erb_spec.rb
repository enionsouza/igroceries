require 'rails_helper'

RSpec.describe "groceries/index", type: :view do
  before(:each) do
    assign(:groceries, [
      Grocery.create!(
        author: nil,
        name: "Name",
        amount: "9.99",
        unit: "Unit"
      ),
      Grocery.create!(
        author: nil,
        name: "Name",
        amount: "9.99",
        unit: "Unit"
      )
    ])
  end

  it "renders a list of groceries" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Unit".to_s, count: 2
  end
end
