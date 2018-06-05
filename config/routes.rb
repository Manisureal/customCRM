Rails.application.routes.draw do
  root to: 'pages#home'
  get 'search_lead', to: 'leads#search_lead'
  get 'please_wait', to: 'leads#please_wait'
  resources :leads, only: [:index, :show, :edit, :update, :new, :create]
  resources :notes, only: [:index, :new, :create]
  resources :contacts, only: [:index, :show]
end
