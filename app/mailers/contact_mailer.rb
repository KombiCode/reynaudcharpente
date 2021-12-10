class ContactMailer < ApplicationMailer
  default from: "contact@kombicode.com"
  def contact_message_email
    blacklist = ENV["PROHIBITED_EMAILS"]
    @contact = params[:contact]
    mail(to: 'contact@kombicode.com', subject: 'Nouveau message de contact') unless blacklist.include? @contact.email
  end
  # def send_signup_email(user)
  #   @user = user
  #   mail( :to => @user.email,
  #   :subject => 'Thanks for signing up for our amazing app' )
  # end

end
