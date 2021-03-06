module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults

      desc "Opperations related to authentication"
      resource :auth, desc: "Log in/out" do

        desc "Creates and returns access_token if valid login"
        params do
          requires :login, type: String, desc: "Username or email address"
          requires :password, type: String, desc: "Password"
        end
        post :login do

          if params[:login].include?("@")
            user = User.find_by_email(params[:login].downcase)
          else
            user = User.find_by_username(params[:login].downcase)
          end

          if user && user.match_password(params[:password])
            key = ApiKey.create(user_id: user.id)
            {token: key.access_token}
          else
            error!('Unauthorized.', 401)
          end
        end

        desc "Returns pong if logged in correctly. Authentication test"
        params do
          requires :token, type: String, desc: "Access token."
        end
        get :ping do
          authenticate!
          { message: "pong" }
        end

        desc "Invalidates the given token"
        params do
          requires :token, type: String, desc: "Token to invalidate"
        end
        delete do
          ApiKey.where(access_token: params[:token]).first.destroy();
        end
      end
    end
  end
end
