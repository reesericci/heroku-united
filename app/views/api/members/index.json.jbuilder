json.array! @members do |m|
  json.username m.username

  json.name m.name
  json.email m.email
  json.pronouns m.pronouns

  json.auxillary m.auxillary

  json.banned m.banned?
  json.expired m.expired?

  json.status m.status
  json.created_at m.created_at
  json.expires_at m.expires_at
end
