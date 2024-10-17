module EmailsHelper
  def email_type_icon(email_type)
    email_type == "outbound" ? "arrow-left-circle" : "arrow-right-circle"
  end
end
