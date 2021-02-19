class API < Grape::API
  format :json
  mount V1::User
  add_swagger_documentation array_use_braces: true
end
