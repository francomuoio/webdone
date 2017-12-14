class ApplicationMailer < ActionMailer::Base
  default from: 'franco.59171@gmail.com'
  layout 'mailer'
end

# def send_simple_message
#   RestClient.post "https://api:key-fb26252d17c5c3f8b4ff0bea9e30a882"\
#   "@api.mailgun.net/v3/sandboxe582175b997846b58cca9357a4a391a4.mailgun.org/messages",
#   :from => "Excited User <franco.59171@gmail.com>",
#   :to => "franco.59171@gmail.com",
#   :subject => "Hello",
#   :text => "Testing some Mailgun awesomness!"
# end
