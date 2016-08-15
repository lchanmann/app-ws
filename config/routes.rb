Rails.application.routes.draw do

  root to: redirect('/nice-co/deployments/1234/postgresql/databases')

  scope '/:account_slug/deployments/:deployment_id' do
    get 'current_queries', to: 'deployments#current_queries'
    namespace :postgresql do
      resources :databases, param: :name, only: [:index] do
        resources :tables, param: :table_name, only: [:index, :show]
      end
    end
  end

end
