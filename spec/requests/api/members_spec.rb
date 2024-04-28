require "swagger_helper"

RSpec.describe "Members" do
  path "/api/members" do
    get "list members" do
      security [basic_auth: []]
      tags "Members"
      response 200, "success" do
        example "application/json", :default, [
          {
            username: "fionahu",
            name: "Fionah United",
            email: "fionahu@obl.ong",
            pronouns: "they/them",
            auxillary: {
              custom_field: "data"
            },
            banned: false,
            expired: false,
            status: "active",
            created_at: "2024-01-01T00:00:00.000Z",
            expires_at: "2025-01-01T00:00:00.000Z"
          },
          {
            username: "steveu",
            name: "Kai United",
            email: "kaiu@obl.ong",
            pronouns: "they/them",
            auxillary: {
              custom_field: "data"
            },
            banned: false,
            expired: false,
            status: "active",
            created_at: "2024-01-02T00:00:00.000Z",
            expires_at: "2025-01-02T00:00:00.000Z"
          }
        ]
        run_test!
      end
    end

    post "create member" do
      security [basic_auth: []]
      tags "Members"
      consumes "application/json"

      parameter name: :member, in: :body, schema: {
        type: :object,
        properties: {
          username: {type: :string},
          name: {type: :string},
          email: {type: :string},
          pronouns: {type: :string},
          auxillary: {type: :object, description: "Unstructured custom fields"},
          banned: {type: :boolean, default: :false},
          expires_at: {type: :string, description: "ISO8601, times in UTC"}
        },
        required: ["username", "email"]
      }

      request_body_example value: { 
        username: "fionahu",
        name: "Fionah United",
        email: "fionahu@obl.ong",
        pronouns: "they/them",
        auxillary: {
          custom_field: "data"
        },
        banned: false,
        expires_at: "2025-01-01T00:00:00.000Z"
      }, name: :default, summary: "default"

      response 200, "success" do
        example "application/json", :default, {
          username: "fionahu",
          name: "Fionah United",
          email: "fionahu@obl.ong",
          pronouns: "they/them",
          auxillary: {
            custom_field: "data"
          },
          banned: false,
          expired: false,
          status: "active",
          created_at: "2024-01-01T00:00:00.000Z",
          expires_at: "2025-01-01T00:00:00.000Z"
        }
        run_test!
      end
    end
  end

  path "/api/members/{username}" do
    parameter name: "username", in: :path, type: :string, description: "username"
    get("show member") do
      security [basic_auth: []]
      tags "Members"
      parameter name: "username", in: :path, type: :string, description: "username"

      response(200, "successful") do
        let(:username) { "fionahu" }

        example "application/json", :default, {
          username: "fionahu",
          name: "Fionah United",
          email: "fionahu@obl.ong",
          pronouns: "they/them",
          auxillary: {
            custom_field: "data"
          },
          banned: false,
          expired: false,
          status: "active",
          created_at: "2024-01-01T00:00:00.000Z",
          expires_at: "2025-01-01T00:00:00.000Z"
        }
        run_test!
      end
    end

    patch "update or create member" do
      security [basic_auth: []]
      tags "Members"
      consumes "application/json"
      parameter name: "username", in: :path, type: :string, description: "username"

      parameter name: :member, in: :body, schema: {
        type: :object,
        properties: {
          username: {type: :string},
          name: {type: :string},
          email: {type: :string},
          pronouns: {type: :string},
          auxillary: {type: :object, description: "Unstructured custom fields"},
          banned: {type: :boolean, default: :false},
          expires_at: {type: :string, description: "ISO8601, times in UTC"}
        },
        required: ["username", "email"]
      }

      request_body_example value: { banned: true }, name: "ban member", summary: "ban member"

      response 200, "success" do
        let(:username) { "fionahu" }
        example "application/json", :default, {
            username: "fionahu",
            name: "Fionah United",
            email: "fionahu@obl.ong",
            pronouns: "they/them",
            auxillary: {
              custom_field: "data"
            },
            banned: true,
            expired: false,
            status: "active",
            created_at: "2024-01-01T00:00:00.000Z",
            expires_at: "2025-01-01T00:00:00.000Z"
          }
        
        run_test!
      end
    end

    delete "delete member" do
      security [basic_auth: []]
      tags "Members"
      parameter name: "username", in: :path, type: :string, description: "username"
      
      response 200, "success" do
        let(:username) { "fionahu" }

        example "application/json", :default, [
          "steveu"
        ], "default", "Array of all member usernames after deletion"
        run_test!
      end
    end
  end
end
