module Api
  module V1
    class AirlinesController < ApplicationController
      def index
        airlines = Airline.all

        render json: AirlineSerializer.new(airlines, options).to_json
      end

      def show
        render json: AirlineSerializer.new(airline, options).to_json
      end

      def create
        airline = Airline.new(airline_params)

        if airline.save
          render json: AirlineSerializer.new(airline).to_json
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      def update
        return render json: { error: "Airline doesn't exist." }, status: 422 if airline.nil?

        if airline.update(airline_params)
          render json: AirlineSerializer.new(airline, options).to_json
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      def destroy
        return render json: { error: "Airline doesn't exist." }, status: 422 if airline.nil?

        if airline.destroy
          head :no_content
        else
          render json: { error: airline.errors.messages }, status: 422
        end
      end

      private

      def airline
        Airline.find_by(slug: params[:slug])
      end

      def airline_params
        params.require(:airline).permit(:name, :image_url)
      end

      def options
        @options ||= { include: %i[reviews] }
      end
    end
  end
end
