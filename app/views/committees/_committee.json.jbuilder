json.extract! committee, :id, :name, :meeting_day, :meeting_time, :meeting_room, :created_at, :updated_at
json.url committee_url(committee, format: :json)
