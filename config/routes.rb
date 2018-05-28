Rails.application.routes.draw do

  devise_for :users

  resources :users

  #companies controller
  get 'show_companies', to: 'companies#index', as: 'companies'  
  get '/companies', to: 'companies#companies', as: 'companies_report'

  #tasks controller
 
  post 'tasks/save_time', to: 'tasks#save_time', as: 'save_time'
  get '/', to: 'tasks#my_tasks', as: 'my_tasks'
  post '/', to: 'tasks#my_tasks', as: 'my_tasks_post'
  get '/complete_task/:id', to: 'tasks#complete_task', as: 'complete_task'
  get '/activate_task/:id', to: 'tasks#activate_task', as: 'activate_task'
  post '/task/update_task_time_spent', to: 'tasks#update_task_time_spent', as: 'update_task_time_spent'

  #users
  get 'show_user/:id', to: 'users#show_user', as: 'show_user'

  #admin tasks
  get '/admin/tasks', to: 'admin#tasks', as: 'admin_tasks'
  post '/admin/tasks/create', to: 'admin#create_task', as: 'admin_create_task'
  get '/admin/delete_task/:id', to: 'admin#destroy_task', as: 'admin_delete_task'
  get '/admin/new_task', to: 'admin#new_task', as: 'admin_new_task'  
  get 'tasks/:id', to: 'admin#show_task', as: 'admin_show_task'
  get '/admin/recreate_tasks', to: 'admin#recreate_tasks', as: 'recreate_tasks'


  #admin companies
  get '/admin/companies', to: 'admin#companies', as: 'admin_companies'
  get '/admin/new_company', to: 'admin#new_company', as: 'new_company'
  post '/admin/create_company', to: 'admin#create_company', as: 'create_company'
  get '/admin/show_company/:id', to: 'admin#show_company', as: 'company'
  get '/admin/edit_company/:id', to: 'admin#edit_company', as: 'edit_company'
  post '/admin/update_company', to: 'admin#update_company', as: 'update_company'
  get '/admin/delete_company/:id', to: 'admin#destroy_company', as: 'delete_company'


end
