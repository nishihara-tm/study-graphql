class GolfUserMailer < ApplicationMailer
  def policy
    @golf_user = params[:golf_user]
    @url  = "https://local/XXXXXX.html?params=#{@golf_user.hash}"
    mail(to: @golf_user.email, subject: '【重要】XXXXXXXXXXXXXX')
  end
end
