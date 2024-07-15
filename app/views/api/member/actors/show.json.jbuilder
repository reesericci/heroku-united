json.set! "@context", "http://purl.org/sodap/spec/main/actor"
json.type "Actor"
json.id api_member_actor_url(@member.username)

json.preferredUsername @member.username

json.name @member.name
json.email @member.email

json.address do
  json.streetAddress @member.address.line1 + (@member.address.line2.present? ? "\n" + @member.address.line2 : "")
  json.addressLocality @member.address.city
  json.addressRegion @member.address.province
  json.addressCountry @member.address.country.name
  json.postalCode @member.address.code
end

json.valid @member.status == "active"