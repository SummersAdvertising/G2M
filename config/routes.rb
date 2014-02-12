G2M::Application.routes.draw do
  resources :records
  root :to => "records#new"

  mount_sextant if Rails.env.development?
  match '*not_found' => 'errors#handle404'
end
