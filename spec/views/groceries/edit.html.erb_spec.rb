require 'rails_helper'

RSpec.describe 'groceries/edit', type: :view do
  before(:each) do
    @grocery = assign(:grocery, Grocery.create!(
                                  author: nil,
                                  name: 'MyString',
                                  amount: '9.99',
                                  unit: 'MyString'
                                ))
  end

  it 'renders the edit grocery form' do
    render

    assert_select 'form[action=?][method=?]', grocery_path(@grocery), 'post' do
      assert_select 'input[name=?]', 'grocery[author_id]'

      assert_select 'input[name=?]', 'grocery[name]'

      assert_select 'input[name=?]', 'grocery[amount]'

      assert_select 'input[name=?]', 'grocery[unit]'
    end
  end
end
