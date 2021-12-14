class ContactsController < ApplicationController
  include CableReady::Broadcaster

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
      ContactMailer.with(contact: @contact).contact_message_email.deliver_now
      respond_to do |format|
        flash = {
          title: t('message_sent'),
          timeout: 4
        }
        format.html { redirect_to root_url, success: flash }
      end
    else
      html = render_to_string(partial: 'form', locals: { contact: @contact })
      render operations: cable_car
        .inner_html('#contact_form', html: html), status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, messages_attributes: [:body])
  end

end