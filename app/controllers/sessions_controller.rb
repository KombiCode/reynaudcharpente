class SessionsController < ApplicationController
  include CableReady::Broadcaster

  def new
    html = render_to_string(partial: 'form')
    render operations: cable_car
      .outer_html('#session_form', html: html)
      .dispatch_event(name: 'modal:loaded')
  end

  def create
    user = login(params[:email], params[:password])
    if user
      flash = {
        title: "Logged in!",
        timeout: 3,
        countdown: false
      }
      html = render_to_string(partial: 'shared/flash_notice', locals: {flash_info: {success: flash}})
      render operations: cable_car
        .inner_html('#session-notifications', html: html)
        .dispatch_event(name: 'submit:success')
    else
      html = render_to_string(partial: 'form')
      render operations: cable_car
        .inner_html('#session_form', html: html), status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
