json.array! @broadcasts do |b|
  json.id b.id

  json.subject b.subject

  json.content b.content.body

  json.created_at b.created_at
end
