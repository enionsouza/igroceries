module ApplicationHelper
  def creation_date(entity)
    entity.created_at.strftime('%a %d %b %Y')
  end
end
