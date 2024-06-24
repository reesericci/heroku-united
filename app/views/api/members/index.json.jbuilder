json.array! @members do |m|
  json.username m.username

  json.name m.name
  json.email m.email
  json.pronouns m.pronouns

  json.extensions m.extensions do |e|
    json.name ActiveSupport::Inflector.humanize(e.name.to_s)
    json.content e.content
  end

  json.address m.address do |a|
    json.line1 a.line1
    json.line2 a.line2
    json.city a.city
    json.province a.province
    json.country a.country
    json.code a.code
  end

  json.banned m.banned?
  json.expired m.expired?

  json.status m.status
  json.created_at m.created_at
  json.expires_at m.expires_at
end
