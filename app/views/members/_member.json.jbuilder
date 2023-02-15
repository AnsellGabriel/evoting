json.extract! member, :id, :event_id, :name, :description, :area, :voted, :vote_date, :station, :created_at, :updated_at
json.url member_url(member, format: :json)
