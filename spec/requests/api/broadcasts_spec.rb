require "swagger_helper"

RSpec.describe "api/broadcasts", type: :request do
  path "/api/broadcasts" do
    get("list broadcasts") do
      tags "Broadcasts"
      security [basic_auth: []]
      response 200, "success" do
        example "application/json", :default, [
          {
            "id": 2,
            "subject": "A subject line 2",
            "content": "<div>Wowza!</div>",
            "created_at": "2024-01-02T00:00:00.000Z"
          },
          {
            "id": 1,
            "subject": "A subject line",
            "content": "<div>wow</div>",
            "created_at": "2024-01-01T00:00:00.000Z"
          },
        ]
        run_test!
      end
    end

    post("create broadcast") do
      security [basic_auth: []]
      tags "Broadcasts"
      consumes "application/json"

      parameter name: :broadcast, in: :body, schema: {
        type: :object,
        properties: {
          subject: {type: :string},
          content: {type: :string}
        },
        required: ["subject", "content"]
      }

      request_body_example value: { 
        subject: "A subject line 3",
        content: "<div>Created with the API!</div>"
      }, name: :default, summary: "default"

      response 200, "success" do
        example "application/json", :default, {
          "id": 3,
          "subject": "A subject line 3",
          "content": "<div>Created with the API!</div>",
          "created_at": "2024-01-03T00:00:00.000Z"
        }
        run_test!
      end
    end
  end

  path "/api/broadcasts/{id}" do
    parameter name: "id", in: :path, type: :integer, description: "id"

    get("show broadcast") do
      security [basic_auth: []]
      tags "Broadcasts"
      parameter name: "id", in: :path, type: :integer, description: "id"

      response 200, "success" do
        let(:id) { 3 }

        example "application/json", :default, {
          "id": 3,
          "subject": "A subject line 3",
          "content": "<div>Created with the API!</div>",
          "created_at": "2024-01-03T00:00:00.000Z"
        }
        run_test!
      end
    end

    delete("delete broadcast") do
      security [basic_auth: []]
      tags "Broadcasts"
      parameter name: "id", in: :path, type: :integer, description: "id"
      
      response(200, "successful") do
        let(:id) { 3 }

        example "application/json", :default, [
          1,
          2
        ]
        run_test!
      end
    end
  end
end
