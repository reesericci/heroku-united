json.username @member.username

json.name @member.name
json.email @member.email
json.pronouns @member.pronouns

json.extensions @member.extensions do |e|
  json.name ActiveSupport::Inflector.humanize(e.name.to_s)
  json.content e.content
end

json.address @member.address do |a|
  json.line1 a.line1
  json.line2 a.line2
  json.city a.city
  json.province a.province
  json.country a.country
  json.code a.code
end

json.banned @member.banned?
json.expired @member.expired?

json.status @member.status
json.created_at @member.created_at
json.expires_at @member.expires_at
