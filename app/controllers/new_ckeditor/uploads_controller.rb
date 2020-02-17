module NewCkeditor
  class UploadsController < ApplicationController

    def upload
      image = CkEditorImage.new(file: params["upload"])
      if image.save
        render json: {
          url: image.file.url
        }
      else
        render json: {
          "error": {
            "message": image.errors.full_messages.join(", ")
          }
        }
      end
    end
  end
end