class UserMailer < ActionMailer::Base
    default :from => "varma.santosh@outlook.com"

    def registration_confirmation(user)
    	@user = user
    	mail(:to => "#{user.full_name} <#{user.email}>", :subject => "Registration Confirmation")
    end
end
