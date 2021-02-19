module V1
  class Point < Grape::API
    # format :json
    # version 'v1'

    resources :Points do
      desc 'Pointを返す' do
        # failure [[401, 'Unauthorized', Entities::Errors::Error]]
        named 'named route'
        success Entities::Point

        headers 'X-AuthToken': {
                  description: 'Validates your identity',
                  required: true
                },
                'X-OptionalHeader': {
                  description: 'Not really needed',
                  required: false
                }
        # hidden false
        # deprecated false
        # is_array true
        nickname 'nickname'
        produces ['application/json']
        consumes ['application/json']
        # tags ['tag1', 'tag2']
      end
      params do
        requires :integer_param, type: Integer, desc: 'description for integer_param'
        optional :string_param, type: String, desc: 'description for string_param'
        optional :array_param, type: Array[Integer], desc: 'description for array_param'
      end
      get do
        ::Class.all
        # represent ::Class.all, with: Entities::User もし型指定したいなら
      end
    end
  end
end
