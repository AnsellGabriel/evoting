json.extract! vote, :id, :event_id, :candidate_id, :member_id, :position_id, :vote_amount, :station, :created_at, :updated_at
json.url vote_url(vote, format: :json)
