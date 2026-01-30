module Admin::EventsHelper
  def assignment_status_class(assignment)
    case assignment.status
    when "confirmed"
      "bg-green-100 text-green-800"
    when "declined"
      "bg-red-100 text-red-800"
    else
      "bg-yellow-100 text-yellow-800"
    end
  end
end