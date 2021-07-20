require 'rails_helper'

RSpec.describe 'Home Page', type: :system do
  before(:each) do
    User.create(name: 'User001')
  end

  it 'first page is the Login Page' do
    visit root_path
    expect(page).to have_content('Login')
  end

  it 'denies access to groceries controllers unless the user is logged in' do
    visit "#{root_path}groceries/index/my-groceries"
    expect(page).to_not have_content('My Groceries')
  end

  it 'denies access to groups controllers unless the user is logged in' do
    visit "#{root_path}groups"
    expect(page).to_not have_content('All Groups')
  end

  it 'redirects user to Login Page from groceries controllers unless the user is logged in' do
    visit "#{root_path}groceries/index/my-groceries"
    expect(page).to have_content('Login')
  end

  it 'redirects user to Login Page from groups controllers unless the user is logged in' do
    visit "#{root_path}groups"
    expect(page).to have_content('Login')
  end

  it 'allows the user logs in to the app, only by typing the username' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    expect(page).to have_content('Hello, User001!')
  end

  it 'allows the user sign up to the app, only by typing an unused username' do
    visit root_path
    click_link 'Signup'
    fill_in 'Name', with: 'John Doe'
    click_button 'Signup'
    expect(page).to have_content('Hello, John Doe!')
  end

  it 'rejects the user to sign up to the app using an existing username' do
    visit root_path
    click_link 'Signup'
    fill_in 'Name', with: 'User001'
    click_button 'Signup'
    expect(page).to have_content('Name has already been taken')
  end

  it 'redirects the user to the main menu (User Profile) page after successufully logged in.' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    expect(page).to have_content('All my groceries')
  end

  it 'redirects the logged in user to the \'My Groceries\' Page, properly' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my groceries'
    expect(page).to have_content('My Groceries (total: 0)')
  end

  it 'redirects the logged in user to the \'My External Groceries\' Page, properly' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All my external groceries'
    expect(page).to have_content('My External Groceries (total: 0)')
  end

  it 'redirects the logged in user to the \'All Groups\' Page, properly' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    click_link 'All groups'
    expect(page).to have_content('All Groups (total: 0)')
  end

  it 'permits the logged in user to logout' do
    visit root_path
    fill_in 'Name', with: 'User001'
    click_button 'Login'
    page.accept_confirm { click_link 'Logout' }
    expect(page).to have_content('Signup')
  end
end
