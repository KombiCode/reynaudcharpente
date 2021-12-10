class ContactMailer < ApplicationMailer
  def contact_message_email
    blacklist = ENV["PROHIBITED_EMAILS"]
    @contact = params[:contact]
    mail(to: 'contact@kombicode.com', subject: 'Nouveau message de contact') unless blacklist.include? @contact.email
  end
end
