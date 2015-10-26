module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users, desc: "Users" do
        desc "Return all users"
        get "", root: :users do
          User.all
        end

        desc "Return a user"
        params do
          optional :username, type: String, desc: "Username of the user"
        end
        get ":username", root: "user" do
          User.where(username: permitted_params[:username]).first!
        end

        desc "Create a user"
        params do
          requires :username, type: String, desc: "Username for the new user"
          requires :email, type: String, desc: "Email for the new user"
          requires :password, type: String, desc: "Password for the new user"
          optional :avatar_id, type: Integer, desc: "ID of avatar for the new user"
          optional :cover_picture_id, type: Integer, desc: "ID of cover picture for the new user"
        end
        post "", root: :users do
          User.create( permitted_params )
        end
      end
      resource :user, desc: "Current user" do
        #TODO: authenticate
        desc "Update the current user"
        params do
          requires :token, type: String, desc: "Authentication token"
          optional :email, type: String, desc: "New Email for the user"
          optional :password, type: String, desc: "New Password for the user"
          optional :avatar_id, type: Integer, desc: "New ID of avatar for the user"
          optional :cover_picture_id, type: Integer, desc: "New ID of cover picture for the user"
        end
        put ":username", root: :users do
          authenticate!
          current_user.update(permitted_params)
        end

        #TODO: Authenticate
        desc "Delete the current user"
        params do
          requires :token, type: String, desc: "Token of authenticity"
        end
        delete ":username", root: :users do
          User.where(username: permitted_params[:username]).delete()
        end
      end
    end
  end
end
