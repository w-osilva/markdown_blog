Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

  resources :posts
  get 'posts/render/:user/:file', to: 'posts#render_html', as: 'post_render_html'
  get 'posts/:id/republish', to: 'posts#republish', as: 'post_republish'

end
