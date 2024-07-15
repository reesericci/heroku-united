json.subject params[:resource]

json.links do
  json.child! do
    json.rel "http://openid.net/specs/connect/1.0/issuer"
    json.href request.base_url
  end
  json.child! do
    json.rel "http://purl.org/sodap/spec/main/actor"
    json.href api_member_actor_url(@member.username)
  end
end
