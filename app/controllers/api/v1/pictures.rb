module API
  module V1
    class Pictures < Grape::API
      include API::V1::Defaults
      resource :pictures do
        desc "Return all pictures for a given user"
        params do
          requires :username, type: String, desc: "Username of user to get pictures for"
        end
        get "user/:username", root: "pictures" do
          User.where(username: params[:username]).first.pictures.all
        end

        #TODO: Are you allowed to access this picture?
        desc "Return a picture"
        params do
          requires :id, type: Integer, desc: "ID of picture"
        end
        get ":id", root: "picture" do
          Picture.find(params[:id])
        end

        desc "Upload a new picture"
        params do
          requires :token, type: String, desc: "Authentication token"
          optional :image, type:  Rack::Multipart::UploadedFile, desc: "Image file"
          optional :name, type: String, desc: "Name for picture"
        end
        post "" do
          authenticate!
          current_user.pictures.create(permitted_params)
        end
      end
    end
  end
end
