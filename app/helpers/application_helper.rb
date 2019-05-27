module ApplicationHelper
  def alert_class(message_type)
    case message_type
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-danger'
    end
  end
end
