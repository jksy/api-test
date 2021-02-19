module V1
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: Integer, desc: 'id of user', example: 1 }
      expose :email, documentation: { type: String, desc: 'email of user', example: 'jksy@example.com'}
      expose :name, documentation: { type: String, desc: 'name of user', example: 'Junichiro Kasuya'}

      expose :name_and_email, documentation: {type: String, desc: 'Junichiro Kasuya<jksy@example.com>'} do |model|
        "#{modelself.name}<#{modelself.email}>"
      end
    end
  end
end

