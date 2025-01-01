module Api
  module V1
    class HostelsController < ApplicationController
      before_action :authorize_admin!, only: [:create, :update, :destroy] 

      def index
        hostels = Hostel.all
        render json: hostels
      end

      def create
        hostel = Hostel.new(hostel_params)
        if hostel.save!
          render json: hostel, status: :created
        else
          render json: { errors: hostel.errors }, status: :unprocessable_entity
        end
      end

      def update
        hostel = Hostel.find_by(id: params[:id])
        if hostel.update(hostel_params)
          render json: hostel
        else
          render json: { errors: hostel.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        hostel = Hostel.find_by(id: params[:id])
        if hostel.destroy
          render json: { message: 'Hostel deleted successfully' }, status: :ok
        else
          render json: { errors: hostel.errors }, status: :unprocessable_entity 
        end
      end

      private

      def hostel_params
        params.require(:hostel).permit(:name, :address, :description) 
      end

      def authorize_admin!
        unless @current_user.admin?
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
    end
  end
end