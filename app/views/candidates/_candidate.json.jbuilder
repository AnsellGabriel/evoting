json.extract! candidate, :id, :event_id, :position_id, :name, :remark, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
