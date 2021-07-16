require 'rails_helper'

RSpec.describe GroceriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index(my-groceries)' do
      expect(get: '/groceries/index/my-groceries').to route_to('groceries#index', mode: 'my-groceries')
    end

    it 'routes to #index(my-external-groceries)' do
      expect(get: '/groceries/index/my-external-groceries').to route_to('groceries#index',
                                                                        mode: 'my-external-groceries')
    end

    it 'routes to #new' do
      expect(get: '/groceries/new').to route_to('groceries#new')
    end

    it 'routes to #show' do
      expect(get: '/groceries/1').to route_to('groceries#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/groceries/1/edit').to route_to('groceries#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/groceries/index/1').to route_to('groceries#create', mode: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/groceries/index/1').to route_to('groceries#update', mode: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/groceries/1').to route_to('groceries#destroy', id: '1')
    end
  end
end
