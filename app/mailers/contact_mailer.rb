class ContactMailer < ApplicationMailer
  def contact_message_email
    blacklist = ENV["PROHIBITED_EMAILS"]
    @contact = params[:contact]
    mail(to: ENV["DEFAULT_SENDER"], subject: 'Nouveau message de contact') unless blacklist.include? @contact.email
  end
end
