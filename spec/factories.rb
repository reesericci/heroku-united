FactoryBot.define do
  factory :my_keyring, class: 'My::Keyring' do
    
  end

  factory :passkey do
    lockable_id { "MyString" }
    lockable_type { "MyString" }
    id { "MyText" }
    lock { "MyText" }
    sign_count { 1 }
  end

  factory :member_verification, class: 'Member::Verification' do
    member { nil }
    verified { false }
    verified_at { "2024-06-27 09:10:17" }
  end

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

  factory :member do
    name { "Fionah United" }
    username { "fionahu" }
    email { "fionah@united.local" }
    expires_at { 1.year.from_now }
  end
end
