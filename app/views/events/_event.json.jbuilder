json.extract! event, :id, :name, :description, :required_complete, :allow_single, :active, :election, :created_at, :updated_at
json.url event_url(event, format: :json)
