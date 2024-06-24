json.username @member.username

json.name @member.name
json.email @member.email
json.pronouns @member.pronouns

json.extensions @member.extensions do |e|
  json.name ActiveSupport::Inflector.humanize(e.name.to_s)
  json.content e.content
end

json.address do
  json.line1 @member.address.line1
  json.line2 @member.address.line2
  json.city @member.address.city
  json.province @member.address.province
  json.country @member.address.country.name
  json.code @member.address.code
end

json.banned @member.banned?
json.expired @member.expired?

json.status @member.status
json.created_at @member.created_at
json.expires_at @member.expires_at
