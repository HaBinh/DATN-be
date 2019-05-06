class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.quote_price.subject
  #
  def quote_price(email, code_html)
    @email = email 
    @html = code_html
    mail to: email
  end
end
