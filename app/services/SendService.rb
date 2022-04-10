class SendService
  def run
    # TODO 実際に送る前にはfalseに変える
    golf_users = GolfUser.where(is_sent: false).all
    golf_users.each do |gu|
      GolfUserMailer.with(golf_user: gu).policy.deliver_now!
      gu.is_sent = true
      gu.save
    rescue => e
      Rails.logger.error(e)
    end
  end
end