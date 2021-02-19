module V1::Entities::Errors
  class Error < Grape::Entity
    expose :message, documentation: { type: String, desc: 'message of error', example: 'message' }
    expose :code, documentation: { type: Integer, desc: 'code of error', example: 1001 }
  end
end

