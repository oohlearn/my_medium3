class Api::UtilsController < Api::BaseController
    # 先驗證格式對不對
    IMAGE_EXT = [".git", ".jpeg", ".jpg", ".png", ".svg"]
    def upload_image
        f = params[:file]

        ext = File.extname(f.original_filename)
        raise "Not allowed" unless IMAGE_EXT.include?(ext)

         blob = ActiveStorage::Blob.create_and_upload!(
            io: f.open,
            filename: f.original_filename,
            content_type: f.content_type
         )
        # 傳給前端顯示圖片
         render json: {link: url_for(blob)}
    end
end


# rails 7.0改版，create_after_upload改為create_and_open，且io要改成f.open才能傳入