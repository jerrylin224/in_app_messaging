class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  def update
    # byebug
    current_user.update(registration_params)
    redirect_to root_path
  end

  private
    def check_captcha
      unless verify_recaptcha(:message => "reCAPTCHA驗證失敗，請再試一次")
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides Recaptcha
        respond_with_navigational(resource) { render :new }
      end 
    end

    def registration_params
      params.require(:user).permit!
    end
end