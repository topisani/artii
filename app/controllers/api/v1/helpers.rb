module API
  module V1
    module Helpers
      def authenticate!
        error!('Unauthorized. Invalid or expired token.', 401) unless current_user
      end

      def current_user
        # find token. Check if valid.
        token = ApiKey.where(access_token: params[:token]).first
        if token && !token.expired?
          @current_user = User.find(token.user_id)
        else
          false
        end
      end

      def permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end

      def logger
        Rails.logger
      end
      
    end
  end
end
