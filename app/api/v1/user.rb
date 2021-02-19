module V1
  class User < Grape::API
    format :json
    version 'v1'

    resources :users do
      class Params < Grape::Entity
        expose :id, documentation: { type: Integer, desc: 'id of user', example: 1234 }
      end

      desc 'ユーザを返す' do
        failure [[401, 'Unauthorized', Entities::Errors::Error]]
        named 'My named route'
        success Entities::User

        headers XAuthToken: {
                  description: 'Validates your identity',
                  required: true
                },
                XOptionalHeader: {
                  description: 'Not really needed',
                  required: false
                }
        hidden false
        deprecated false
        is_array true
        nickname 'nickname'
        produces ['application/json']
        consumes ['application/json']
        tags ['tag1', 'tag2']
      end
      params do
        requires :integer_param, type: Integer, desc: 'description for integer_param'
        optional :string_param, type: String, desc: 'description for string_param'
        optional :array_param, type: Array[Integer], desc: 'description for array_param'
      end
      get do
        ::User.all
        # represent ::User.all, with: Entities::User もし型指定したいなら
      end
    end
  end
end

