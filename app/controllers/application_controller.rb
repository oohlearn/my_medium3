class ApplicationController < ActionController::Base
    rescue_from ArgumentError, with: :record_not_found

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :intro])
    end
    private
    
    def record_not_found
        render file: "#{Rails.root}/public/404.html",
               status: :not_found,
               layout: true
    end
    # 如果發現錯誤訊息，就將狀態變為not_found，並渲染檔案404.html，
    # 然後看要不要帶入預設的layout（不要就false）
end
