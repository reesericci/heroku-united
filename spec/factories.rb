FactoryBot.define do
  factory :config do
    organization { "United!" }
    membership_length { 365 }
    email { "united@example.com" }
    password { "united" }
    extensions { ["Example"] }
    external_url { "united.local" }
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
end
