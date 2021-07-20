# rubocop:disable Style/CombinableLoops

data = {
  'Beverages' => ['https://images.unsplash.com/photo-1527960471264-932f39eb5846',
                  [%w[coffee kg], %w[tea kg], %w[juice bottle], %w[soda bottle]]],
  'Bakery' => ['https://images.unsplash.com/photo-1509440159596-0249088772ff',
               [['sandwich loaves', 'unity'], ['dinner rolls', 'unity'], %w[tortillas unity], %w[bagels unity]]],
  'Canned/Jarred Goods' => ['https://images.unsplash.com/photo-1534483509719-3feaee7c30da',
                            [%w[vegetables pot], ['spaghetti sauce', 'pack'], %w[ketchup bottle]]],
  'Dairy' => ['https://images.unsplash.com/photo-1523473827533-2a64d0d36748',
              [%w[cheeses kg], %w[eggs dozen], %w[milk carton], %w[yogurt pack], %w[butter kg]]],
  'Dry/Baking Goods' => ['https://images.unsplash.com/photo-1614373532018-92a75430a0da',
                         [%w[cereals box], %w[flour kg], %w[sugar kg], %w[pasta kg], %w[mixes kg]]],
  'Frozen Foods' => ['https://images.unsplash.com/photo-1601599967100-f16100982063',
                     [%w[waffles unity], %w[vegetables bag], ['individual meals', 'unity'], ['ice cream', 'pot']]],
  'Meat' => ['https://images.unsplash.com/photo-1607623814075-e51df1bdc82f',
             [['lunch meat', 'kg'], %w[poultry kg], %w[beef kg], %w[pork kg]]],
  'Fruits' => ['https://images.unsplash.com/photo-1610832958506-aa56368176cf',
               [%w[oranges unity], %w[grapefruits unity], %w[bananas palm], %w[mangoes unity], %w[strawberries unity],
                %w[watermelons unity]]],
  'Vegetables' => ['https://images.unsplash.com/photo-1557844352-761f2565b576',
                   [%w[lettuce unity], %w[spinach kg], %w[cabbage kg], %w[cauliflower kg], %w[potato kg],
                    ['sweet potato', 'kg'], %w[onion kg], %w[garlic kg]]],
  'Cleaners' => ['https://images.unsplash.com/photo-1583907659441-addbe699e921',
                 [%w[all-purpose bottle], ['laundry detergent', 'bottle'], ['dishwashing liquid/detergent', 'bottle']]],
  'Paper Goods' => ['https://images.unsplash.com/photo-1584556812952-905ffd0c611a',
                    [['paper towels', 'roll'], ['toilet paper', 'roll'], ['aluminum foil', 'roll'],
                     ['sandwich bags', 'roll']]],
  'Personal Care' => ['https://images.unsplash.com/photo-1610595426075-eed5a3f521ee',
                      [%w[shampoo bottle], %w[soap unity], ['hand soap', 'unity'], ['shaving cream', 'bottle']]]
}

# Seeds for 'users' table
User.create([{ name: 'User001' }, { name: 'User002' }, { name: 'User003' }, { name: 'User004' }, { name: 'User005' }])

# Seeds for 'groups' table
data.keys.each do |group_name|
  User.all.sample.groups.create(name: group_name, icon: data[group_name][0])
end

# Seeds for 'groceries' table
data.keys.each do |group_name|
  data[group_name][1].length.times do |grocery|
    Group.find_by(name: group_name).groceries.create(
      author_id: User.all.sample.id,
      name: data[group_name][1][grocery][0],
      amount: [*1..5].sample,
      unit: data[group_name][1][grocery][1]
    )
  end
end

# rubocop:enable Style/CombinableLoops
