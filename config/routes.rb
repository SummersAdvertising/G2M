G2M::Application.routes.draw do
  resources :tickets
  resources :static_pages

  resources :records, :except => [:index, :show, :destroy] do
  	collection do
  		get :new_for_iframe
      get :thanks
  	end

  	member do
  		get :edit_for_iframe
  	end
  end

  root :to => "records#new"

  mount_sextant if Rails.env.development?
  match '*not_found' => 'errors#handle404'
end
