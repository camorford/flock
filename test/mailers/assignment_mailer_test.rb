require "test_helper"

class AssignmentMailerTest < ActionMailer::TestCase
  test "volunteer_assigned" do
    mail = AssignmentMailer.volunteer_assigned
    assert_equal "Volunteer assigned", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
