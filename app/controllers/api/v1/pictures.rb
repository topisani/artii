module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :pictures do
        desc "Return all pictures for a given user"
        params do
          requires :username, type: String, desc: "Username of the contact"
        end
        get ":", root: "" do
          User.all
        end

        desc "Return a user"
        params do
          requires :username, type: String, desc: "Username of the contact"
        end
        get ":username", root: "user" do
          User.where(username: permitted_params[:username]).first!
        end
      end
    end
  end
end
