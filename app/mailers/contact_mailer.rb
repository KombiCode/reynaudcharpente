include MessagesHelper
class ContactMailer < ApplicationMailer
  def contact_message_email
    blacklist = ENV["PROHIBITED_EMAILS"]
    @contact = params[:contact]
    @project_schedule = MessagesHelper.human_attribute_project_schedules[@contact.messages.first.project_schedule]
    mail(to: ENV["DEFAULT_SENDER"], subject: 'Nouveau message de contact') unless blacklist&.include? @contact.email
  end
end
