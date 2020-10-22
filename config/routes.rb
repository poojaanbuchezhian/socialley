Rails.application.routes.draw do
  get 'user/index'
  get 'user/register'
  post 'user/register'
  get 'user/login'
  post 'user/login'
  get 'user/logout'
  get 'user/edit'
  post 'user/edit'
  get 'site/index'
  get 'site/about'
  get 'site/help'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
