Gardian::Application.routes.draw do

  namespace :api do
    resources :clients
  end


  namespace :admin do
    resources :clients
  end


  devise_for :admins

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  
  # Sample resource route within a namespace:
  namespace :admin do
    root :to => 'base#index'
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)

  end
  namespace :user do
    root :to => 'entries#index'
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    resources :entries
    
  end
 
  namespace :api do
    resource :user do
      member do
        post :sign_in
        get :sign_out
      end
    end

    match '/check_in', to: 'entries#check_in'
    match '/check_out', to: 'entries#check_out'
    match '/check_entry', to: 'entries#check'
    match '/list_on', to: 'entries#list_on'
    match '/show_entry', to: 'entries#show'
    match '/list_off', to: 'entries#list_off'
    match '/filter_by_name', to: 'entries#filter_by_name'
    match '/change_pass', to: 'users#change_pass'
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'
  
  match '/new_entry', to: 'home#new_entry'
  match '/save_entry', to: 'home#save_entry'
 
  match '/media/*dragonfly', :to => Dragonfly[:images]

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  
end
