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
      html = render_to_string(partial: 'contact', locals: { contact: @contact })
      render operations: cable_car
        .append('#contacts', html: html)
        .dispatch_event(name: 'submit:success')
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