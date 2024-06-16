class JoinMailerPreview < ActionMailer::Preview
  def confirmation
    JoinMailer.with(member: Member.first).confirmation
  end
end
