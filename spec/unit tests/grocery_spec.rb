require 'rails_helper'

RSpec.describe Grocery, type: :model do
  describe 'checks if the grocery arguments are valid before creating a new record' do
    it 'rejects the an empty name for grocery creation' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.new(name: '', author_id: author1.id, amount: 400, unit: 'g')
      expect(grocery1.valid?).to eq(false)
    end

    it 'validates a new grocery with a valid name' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.new(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
      expect(grocery1.valid?).to eq(true)
    end

    it 'validates the creation of a new grocery with a repeated name' do
      author1 = User.create!(name: 'John Doe')
      Grocery.create(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
      grocery1 = Grocery.new(name: 'Powder milk', author_id: author1.id, amount: 800, unit: 'g')
      grocery1.valid?
      expect(grocery1.valid?).to eq(true)
    end

    it 'rejects the creation of a new grocery without an assigned author' do
      grocery1 = Grocery.new(name: 'Powder milk', amount: 800, unit: 'g')
      grocery1.valid?
      expect(grocery1.errors.full_messages).to eq(['Author must exist'])
    end

    it 'rejects the creation of a new grocery if the amount is not a number' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.new(name: 'Powder milk', author_id: author1.id, amount: 'two', unit: 'can')
      grocery1.valid?
      expect(grocery1.errors.full_messages).to eq(['Amount is not a number'])
    end

    it 'validates the creation of a new grocery without any unit' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.new(name: 'Eggs', author_id: author1.id, amount: 12)
      expect(grocery1.valid?).to eq(true)
    end
  end

  it 'deletes a grocery' do
    author1 = User.create!(name: 'John Doe')
    grocery1 = Grocery.create!(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
    grocery1.delete
    expect(Grocery.all.count).to eq(0)
  end

  describe 'checks if the grocery arguments are valid before updating an existing record' do
    it 'rejects the an empty name for grocery updating' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.create!(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
      grocery1.update(name: '')
      expect(grocery1.valid?).to eq(false)
    end

    it 'rejects the an empty author_id for grocery updating' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.create!(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
      grocery1.update(author_id: '')
      expect(grocery1.valid?).to eq(false)
    end

    it 'rejects a grocery updating if the amount is not a number' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.create!(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
      grocery1.update(amount: '')
      expect(grocery1.errors.full_messages).to eq(['Amount can\'t be blank', 'Amount is not a number'])
    end

    it 'validates a grocery updating with valid inputs' do
      author1 = User.create!(name: 'John Doe')
      grocery1 = Grocery.create!(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
      author2 = User.create!(name: 'John Smith')
      grocery1.update(name: 'Milk', author_id: author2.id, amount: 5, unit: 'l')
      expect(grocery1.valid?).to eq(true)
    end
  end

  context 'as a collection for User model' do
    describe 'checks if the grocery arguments are valid before creating a new record' do
      it 'rejects the an empty name for grocery creation' do
        author1 = User.create!(name: 'John Doe')
        grocery1 = author1.groceries.build(amount: 1)
        grocery1.valid?
        expect(grocery1.errors.full_messages).to eq(['Name can\'t be blank'])
      end

      it 'rejects the an empty amount for grocery creation' do
        author1 = User.create!(name: 'John Doe')
        grocery1 = author1.groceries.build(name: 'Powder milk')
        grocery1.valid?
        expect(grocery1.errors.full_messages).to eq(['Amount can\'t be blank', 'Amount is not a number'])
      end

      it 'validates a new grocery with a valid inputs' do
        author1 = User.create!(name: 'John Doe')
        grocery1 = author1.groceries.build(name: 'Powder milk', amount: 400, unit: 'g')
        expect(grocery1.valid?).to eq(true)
      end
    end

    it 'accesses all the groceries associated to a user' do
      author1 = User.create!(name: 'John Doe')
      author1.groceries.create(name: 'Powder milk', amount: 400, unit: 'g')
      author1.groceries.create(name: 'Milk', amount: 5, unit: 'l')
      expect(author1.groceries.count).to eq(2)
    end
  end

  context 'as a collection for Group model' do
    describe 'checks if the grocery arguments are valid before creating a new record' do
      it 'rejects the an empty name for grocery creation' do
        author1 = User.create!(name: 'John Doe')
        group1 = author1.groups.create!(name: 'Dairy')
        grocery1 = group1.groceries.build(author_id: author1.id, amount: 400, unit: 'g')
        expect(grocery1.valid?).to eq(false)
      end

      it 'rejects the an empty author for grocery creation' do
        author1 = User.create!(name: 'John Doe')
        group1 = author1.groups.create!(name: 'Dairy')
        grocery1 = group1.groceries.build(name: 'Powder milk', amount: 400, unit: 'g')
        expect(grocery1.valid?).to eq(false)
      end

      it 'rejects the an empty amount for grocery creation' do
        author1 = User.create!(name: 'John Doe')
        group1 = author1.groups.create!(name: 'Dairy')
        grocery1 = group1.groceries.build(name: 'Powder milk', author_id: author1.id, unit: 'g')
        expect(grocery1.valid?).to eq(false)
      end

      it 'validates a new grocery with valid input' do
        author1 = User.create!(name: 'John Doe')
        group1 = author1.groups.create!(name: 'Dairy')
        grocery1 = group1.groceries.build(name: 'Powder milk', author_id: author1.id, amount: 400, unit: 'g')
        expect(grocery1.valid?).to eq(true)
      end
    end
  end
end
