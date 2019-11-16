class ImagesController < ApplicationController
    before_action :set_image, only: [:show]

    # GET /images/1
    def show
        send_data Base64.decode64(@image.base64), type: 'image/png', disposition: 'inline'
    end

    private
    def set_image
        @image = Image.find(params[:id])
    end
end
  