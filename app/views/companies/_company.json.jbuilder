json.extract! company, :id, :name, :city, :state, :founded_on, :description, :created_at, :updated_at
json.url company_url(company, format: :json)
