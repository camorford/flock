class AssignmentMailer < ApplicationMailer
  def volunteer_assigned(assignment)
    @assignment = assignment
    @user = assignment.user
    @event = assignment.event
    @position = assignment.position

    mail(
      to: @user.email_address,
      subject: "You've been scheduled: #{@event.name}"
    )
  end
end