require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'checks if the user arguments are valid before creating a new record' do
    it 'rejects the an empty name for user creation' do
      user1 = User.new(name: '')
      expect(user1.valid?).to eq(false)
    end

    it 'validates a new user with a valid name' do
      user1 = User.new(name: 'John Doe')
      expect(user1.valid?).to eq(true)
    end

    it 'rejects the creation of a new user with a repeated name' do
      User.create(name: 'John Doe')
      user1 = User.new(name: 'John Doe')
      expect(user1.valid?).to eq(false)
    end
  end

  it 'deletes a user' do
    user1 = User.create!(name: 'John Doe')
    user1.delete
    expect(User.all.count).to eq(0)
  end

  describe 'checks if the user arguments are valid before updating an existing record' do
    it 'rejects the an empty name for user updating' do
      user1 = User.create!(name: 'John Doe')
      user1.update(name: '')
      expect(user1.valid?).to eq(false)
    end

    it 'validates a user updating with a valid name' do
      user1 = User.create!(name: 'John Doe')
      user1.update(name: 'John Smith')
      expect(user1.valid?).to eq(true)
    end

    it 'rejects the updating of an existing user with a repeated name' do
      User.create(name: 'John Doe')
      user1 = User.create!(name: 'John Smith')
      user1.update(name: 'John Doe')
      expect(user1.valid?).to eq(false)
    end
  end
end
