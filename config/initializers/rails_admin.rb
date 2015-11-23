RailsAdmin.config do |config|

  ## == Devise ==
  config.authenticate_with do |controller|
    warden.authenticate! scope: :user
    unless current_user.try(:admin?)
      flash.now[:error] = "Invalid access"
      redirect_to edit_user_registration_url
    end
  end
  config.current_user_method(&:current_user)

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

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model User do
    # list do
    #   field :email
    #   field :admin
    # end

    edit do
      field :email
      field :password
      field :password_confirmation
      field :admin
    end
    configure :email do
      label "Email Address"
    end
  end
end
