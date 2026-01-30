# Preview all emails at http://localhost:3000/rails/mailers/assignment_mailer
class AssignmentMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/assignment_mailer/volunteer_assigned
  def volunteer_assigned
    AssignmentMailer.volunteer_assigned
  end
end
