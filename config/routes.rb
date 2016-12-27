Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  resources :chat_rooms, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'

  root 'main#index'
  get '/edit_profile' => 'main#user_profile'
  delete '/chat_rooms' => 'main#chat_room_delete'
  delete '/chat_rooms' => 'main#chat_room_clear'
  patch '/edit_profile' => 'main#user_profile_edit'
end
