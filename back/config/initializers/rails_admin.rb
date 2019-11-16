RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    
    config.authenticate_with do
      authenticate_or_request_with_http_basic('Login required') do |email, password|
        if email == 'admin@123.321' && password == Rails.configuration.passsssss
          true
        end
      end
    end


    ## With an audit adapter, you can add:
    # history_index
    # history_show

    config.model 'Image' do
      field :current_image do
        read_only true
        formatted_value do
          if bindings[:object]
            bindings[:view].tag(:img, { src: "/images/#{bindings[:object].id}", width: 300, height: 200, style: "object-fit: cover;" })
          end
        end
      end

      field :image_file, :file_upload do
        thumb_method do
          return resource_url
        end
        delete_method do
        end 
        cache_method do
        end 
        def image?
          true
        end
        def resource_url 
          return nil
        end
      end
    end
  end
end
