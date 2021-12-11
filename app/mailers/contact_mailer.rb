class ContactMailer < ApplicationMailer
  def contact_message_email
    blacklist = ENV["PROHIBITED_EMAILS"]
    attachments.inline['rc-banner01.png'] = File.read('app/assets/images/rc-banner01.png')
    @contact = params[:contact]
    mail(to: ENV["DEFAULT_SENDER"], subject: 'Nouveau message de contact') unless blacklist&.include? @contact.email
  end
end
