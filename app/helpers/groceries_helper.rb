module GroceriesHelper
  def amount_with_unit(grocery)
    grocery.unit.length > 2 ? pluralize(grocery.amount, grocery.unit) : "#{grocery.amount} #{grocery.unit}"
  end
end
