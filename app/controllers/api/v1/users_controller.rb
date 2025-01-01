module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!
      def signup
        @user = User.new(user_params)

        if @user.save
          render json: { message: 'User created successfully', user: @user }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        @user = User.find_by(email: params[:email])

        if @user&.valid_password?(params[:password])
          token = generate_jwt_token(@user)
          render json: { message: 'Login successful', token: token }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role)
      end

      def generate_jwt_token(user)
        payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
        JWT.encode(payload,'b3bae0b0f45090149405733cddbabefa173b54ed29efa1d942d9b81373dcbfc521d9319936b22d0723d83a2de9e6145dcbdbaddfc6ae5433fc3bf3f36ded3fe8', 'HS256')
      end
    end
  end
end
