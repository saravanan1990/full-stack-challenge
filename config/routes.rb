Rails.application.routes.draw do
  resources :categories
  resources :founders
  resources :companies do
    collection do
  		post 'search_companies'
  	end
  end
  root :to => "companies#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
