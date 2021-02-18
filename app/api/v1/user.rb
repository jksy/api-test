module V1
  class User < Grape::API
    format :json
    version 'v1'

    resources :users do
      get do
        ::User.all
      end
    end
  end
end

