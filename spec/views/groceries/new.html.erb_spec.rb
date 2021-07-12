require 'rails_helper'

RSpec.describe "groceries/new", type: :view do
  before(:each) do
    assign(:grocery, Grocery.new(
      author: nil,
      name: "MyString",
      amount: "9.99",
      unit: "MyString"
    ))
  end

  it "renders new grocery form" do
    render

    assert_select "form[action=?][method=?]", groceries_path, "post" do

      assert_select "input[name=?]", "grocery[author_id]"

      assert_select "input[name=?]", "grocery[name]"

      assert_select "input[name=?]", "grocery[amount]"

      assert_select "input[name=?]", "grocery[unit]"
    end
  end
end
