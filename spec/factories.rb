require "demo_mode/factory_bot_ext"

FactoryBot.define do
  factory :config do
    organization { "United!" }
    membership_length { 365 }
    email { "united@example.com" }
    password { "correct-horse-battery-staple" }
    extensions { ["Example"] }
    external_url { Rails.env.demo? ? (ENV["DEMO_EXTERNAL_URL"] || "https://demo.united.obl.ong") : "http://localhost:3000" }
    smtp {
      {
        server: "example.com",
        port: 587,
        username: "example",
        password: "example",
        box: "united",
        domain: "example.com"
      }
    }
  end

  factory :member do
    sequence(:name) { "Person #{_1}" }
    sequence(:username) { "person#{_1}" }
    sequence(:email) { "person#{_1}@example.com" }
    expires_at { 1.year.from_now }
    keycode_imprint_attributes { {email: true} }
  end
end
