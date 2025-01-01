class ApplicationController < ActionController::API
	  include ActionController::Helpers 

  before_action :authenticate_user!
  
  private

	def authenticate_user!
	  token = request.headers['token']
	  if token.nil?
	    render json: { error: 'Token missing' }, status: :unauthorized and return
	  end

	  begin
	  	decoded_token = JWT.decode(token, "b3bae0b0f45090149405733cddbabefa173b54ed29efa1d942d9b81373dcbfc521d9319936b22d0723d83a2de9e6145dcbdbaddfc6ae5433fc3bf3f36ded3fe8", true, { algorithm: 'HS256' }) 
	    @current_user = User.find(decoded_token[0]['user_id'])
	  rescue JWT::DecodeError => e
	    render json: { error: 'Invalid or expired token' }, status: :unauthorized and return
	  end
	end

	def set_current_user
		@current_user
  end
  helper_method :current_user
end
