require 'rails_helper'

RSpec.describe 'Groups Pages', type: :system do
  before(:each) do
    author1 = User.create!(name: 'User001')
    group1 = author1.groups.create!(name: 'Group 1')
    group2 = author1.groups.create!(name: 'Group 2')
    grocery1 = author1.groceries.create!(name: 'Grocery 1', amount: 4, unit: 'bottle')
    grocery2 = author1.groceries.create!(name: 'Grocery 2', amount: 8, unit: 'kg')
    grocery3 = author1.groceries.create!(name: 'Grocery 3', amount: 2, unit: 'l')
    grocery1.groups << group1
    grocery2.groups << group2
    grocery3.groups << group2
  end

  it 'allows user to see all groups on \'All groups\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    expect(page).to have_content('All Groups (total: 2)')
  end

  it 'allows user to see all groceries from a group' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 2'
    expect(page).to have_content('Groceries from Group \'Group 2\' (total: 2)')
  end

  it 'allows user to access an specific grocery from \'All Groups\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 2'
    click_link 'Grocery 2'
    expect(page).to have_content('This grocery belongs to:')
  end

  it 'allows user to access the \'New Group\' form Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'New Group'
    expect(page).to have_content('Enter a valid URL for an image to represent this group.')
  end

  it 'allows user to create a new group' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'New Group'
    fill_in 'Name', with: 'Group 3'
    click_button 'Submit'
    expect(page).to have_content('Group was successfully created.')
  end

  it 'rejects a group creation for invalid input' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'New Group'
    fill_in 'Name', with: 'Group 1'
    click_button 'Submit'
    expect(page).to have_content('Name has already been taken')
  end

  it 'allows user to edit a group' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 1'
    click_link 'Edit this Group'
    expect(page).to have_content('Editing Group')
  end

  it 'allows user to update a group' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 1'
    click_link 'Edit this Group'
    fill_in 'Icon',	with: 'https://cdn.iconscout.com/icon/free/png-256/ruby-226055.png'
    click_button 'Submit'
    expect(page).to have_content('Group was successfully updated')
  end

  it 'rejects a group update for invalid input' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    click_link 'Group 1'
    click_link 'Edit this Group'
    fill_in 'Icon',	with: 'https://www.google.com/'
    click_button 'Submit'
    expect(page).to have_content('Icon is not a valid image')
  end
end
