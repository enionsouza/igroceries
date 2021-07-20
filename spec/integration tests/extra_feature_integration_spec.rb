require 'rails_helper'

RSpec.describe 'Extra feature (private groceries)', type: :system do
  before(:each) do
    author1 = User.create!(name: 'User001')
    group1 = author1.groups.create!(name: 'Group 1')
    group2 = author1.groups.create!(name: 'Group 2')
    grocery1 = author1.groceries.create!(name: 'Grocery 1', amount: 4, unit: 'bottle', private: true)
    grocery2 = author1.groceries.create!(name: 'Grocery 2', amount: 8, unit: 'kg', private: false)
    grocery3 = author1.groceries.create!(name: 'Grocery 3', amount: 2, unit: 'l')
    grocery1.groups << group1
    grocery2.groups << group2
    grocery3.groups << group2
  end

  it 'allows user to see all their groceries on \'All my groceries\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    expect(page).to have_content('My Groceries (total: 3)')
  end

  it 'displays the correct badge for private groceries' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    expect(page).to have_content('Grocery 1 Private')
  end
  
  it 'displays the correct badge for public groceries' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    expect(page).to have_content('Grocery 3 Public')
  end

  it 'allows user to update privacy for private groceries' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 1'
    click_link 'Edit'
    page.uncheck('keep it private')
    click_button 'Submit'
    expect(page).to have_content('Grocery 1 Public')
  end

  it 'allows user to update privacy for public groceries' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 2'
    click_link 'Edit'
    page.check('keep it private')
    click_button 'Submit'
    expect(page).to have_content('Grocery 2 Private')
  end

  it 'doesn\'t display private groceries on \'All groups\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 1'
    expect(page).to have_content('Groceries from Group \'Group 1\' (total: 0)')
  end

    it 'displays public groceries on \'All groups\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 2'
    expect(page).to have_content('Groceries from Group \'Group 2\' (total: 2)')
  end
end