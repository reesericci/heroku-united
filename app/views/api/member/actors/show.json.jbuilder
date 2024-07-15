json.set! "@context", ["http://purl.org/sodap/spec/main/actor", {
  "self": "#{api_member_actor_url(@member.username)}/"
}]

json.set! "@graph" do
  (Extension.try(:names)&.keys || []).each do |e|
    json.child! do
      json.set! "@id", "self:#{e.to_s}"
      json.set! "@type", "Text"
      json.set! "rdfs:label", ActiveSupport::Inflector.humanize(e.to_s)
    end
  end
  json.child! do
    json.set! "@id", "self:created_at"
    json.set! "@type", "DateTime"
    json.set! "rdfs:label", "Created at"
    json.set! "rdfs:comment", "When the Member was first created"
  end
  json.child! do
    json.set! "@id", "self:updated_at"
    json.set! "@type", "DateTime"
    json.set! "rdfs:label", "Updated at"
    json.set! "rdfs:comment", "When the Member was last updated"
  end
  json.child! do
    json.set! "@id", "self:expires_at"
    json.set! "@type", "DateTime"
    json.set! "rdfs:label", "Expires at"
    json.set! "rdfs:comment", "When the Member will expire/expired"
  end
end

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

json.additionalProperties do
  @member.extensions.each do |e|
    json.child! do
      json.set! "@type", "self:#{e.name}"
      json.set! "@value", e.content
    end
  end
  json.child! do
    json.set! "@type", "self:created_at"
    json.set! "@value", @member.created_at
  end
  json.child! do
    json.set! "@type", "self:updated_at"
    json.set! "@value", @member.updated_at
  end
  json.child! do
    json.set! "@type", "self:expires_at"
    json.set! "@value", @member.expires_at
  end
end