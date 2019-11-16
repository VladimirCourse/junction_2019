class Image
    include Mongoid::Document
    field :base64, type: String

    attr_accessor :image_file

    before_save :create_image

    def create_image 
        if image_file
            self.base64 = Base64.encode64(image_file.read)
        end
    end
end
