module Api
  module V1
    # Controller to handle sign in and sign out actions
    class SessionsController < ApplicationController

      #Sign in user
      def create
        password = params[:session][:password]
        email = params[:session][:email]
        user = email.present? && User.find_by(email: email)

        if user.valid_password? password
          sign_in_user(user)
          render json: user, status: 200, location: [:api, user]
        else
          render json: { errors: 'Invalid email or password' }, status: 422
        end
      end

      #Sign out user
      def destroy
        user = User.find_by(auth_token: params[:id])
        user.generate_authentication_token!
        user.save
      end

      private

      def sign_in_user(user)
        sign_in user, store: false
        user.generate_authentication_token!
        user.save!
      end
    end
  end
end
