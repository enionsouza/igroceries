require 'rails_helper'

RSpec.describe 'Groceries Pages', type: :system do
  before(:each) do
    author1 = User.create!(name: 'User001')
    grocery1 = author1.groceries.create!(name: 'Grocery 1', amount: 4, unit: 'bottle')
    group1 = author1.groups.create!(name: 'Group 1')
    grocery1.groups << group1
    author1.groceries.create(name: 'Grocery 2', amount: 8, unit: 'kg')
    author1.groceries.create(name: 'Grocery 3', amount: 2, unit: 'l')
  end

  it 'allows user to see all their groceries on \'All my groceries\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    expect(page).to have_content('My Groceries (total: 3)')
  end

  it 'allows user to see only their external groceries (which don\'t belong to any group)
on \'All my external groceries\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my external groceries'
    expect(page).to have_content('My External Groceries (total: 2)')
  end

  it 'allows user to access the \'new grocery\' form page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'New Grocery'
    expect(page).to have_content('New Grocery')
  end

  it 'allows user to create a new grocery' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'New Grocery'
    fill_in 'Name', with: 'Grocery 4'
    fill_in 'Amount', with: 5
    fill_in 'Unit', with: 'bag'
    page.check('Group 1')
    click_button 'Submit'
    expect(page).to have_content('Grocery was successfully created.')
  end

  it 'rejects the creation of a grocery with errors' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'New Grocery'
    fill_in 'Amount', with: 5
    fill_in 'Unit', with: 'bag'
    page.check('Group 1')
    click_button 'Submit'
    expect(page).to have_content('Name can\'t be blank')
  end

  it 'allows user to see all the details of an specific grocery' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 2'
    expect(page).to have_content('8.0 kg')
  end

  it 'allows user to see all the details of an specific grocery with the correct amount' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 1'
    expect(page).to have_content('4.0 bottles')
  end

  it 'allows user to delete a grocery' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 1'
    page.accept_confirm { click_link 'Delete' }
    expect(page).to_not have_content('Grocery 1')
  end

  it 'allows user to edit a grocery' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 1'
    click_link 'Edit'
    expect(page).to have_content('Editing Grocery')
  end

  it 'allows user to update a grocery' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 2'
    click_link 'Edit'
    page.check('Group 1')
    click_button 'Submit'
    expect(page).to have_content('Grocery was successfully updated')
  end

  it 'rejects the update of a grocery with errors' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    click_link 'Grocery 2'
    click_link 'Edit'
    fill_in 'Name', with: ''
    click_button 'Submit'
    expect(page).to have_content('Name can\'t be blank')
  end
end
