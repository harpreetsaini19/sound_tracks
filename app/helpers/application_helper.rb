module ApplicationHelper

  def display_flash
    html = ""
    flash.each do |type, message|
      html << \
      if type.to_s == "alert"
        flash_single_alert_message(message)
      else
        flash_single_success_message(message)
      end
    end
    html.html_safe
  end

  private

  def flash_single_alert_message(message)
    content_tag :div, class: "flash alert alert-danger" do
      ( button_tag 'x', class: "close", data: {dismiss: "alert"} ) + message
    end
  end

  def flash_single_success_message(message)
    content_tag :div, class: "flash alert alert-success" do
      ( button_tag 'x', class: "close", data: {dismiss: "alert"} ) + message
    end
  end
end
