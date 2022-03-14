class ContactsController < ApplicationController
  include CableReady::Broadcaster
  invisible_captcha only: [:create, :update], honeypot: :subtitle

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
    @contact.messages.build
    html = render_to_string(partial: 'form', locals: { contact: @contact })
    render operations: cable_car
      .outer_html('#contact_form', html: html)
      .dispatch_event(name: 'modal:loaded')
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash = {
        title: t('message_sent'),
        timeout: 4,
        countdown: true
      }
      html = render_to_string(partial: 'shared/flash_notice', locals: {flash_info: {success: flash}})
      ContactMailer.with(contact: @contact).contact_message_email.deliver_now
      render operations: cable_car
        .inner_html('#bound-notifications', html: html)
        .dispatch_event(name: 'submit:success')
    else
      # need to 'rebuild' messages area
      @contact.messages.build
      html = render_to_string(partial: 'form', locals: { contact: @contact })
      render operations: cable_car
        .inner_html('#contact_form', html: html), status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :zipcode_id, messages_attributes: [:body, :project_schedule])
  end

end
