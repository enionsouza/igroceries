json.extract! grocery, :id, :author_id, :name, :amount, :unit, :created_at, :updated_at
json.url grocery_url(grocery, format: :json)
