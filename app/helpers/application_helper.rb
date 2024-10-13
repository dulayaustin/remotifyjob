module ApplicationHelper
  def flash_color(flash_type)
    {
      notice: "text-green-800 border-green-300 bg-green-50 dark:text-green-400 dark:border-green-800",
      alert: "text-red-800 border-red-300 bg-red-50 dark:text-red-400 dark:border-red-800"
    }[flash_type.to_sym]
  end

  def flash_close_button_color(flash_type)
    {
      notice: "bg-green-50 text-green-500 focus:ring-green-400 hover:bg-green-200 dark:text-green-400",
      alert: "bg-red-50 text-red-500 focus:ring-red-400 hover:bg-red-200 dark:text-red-400"
    }[flash_type.to_sym]
  end

  def fetch_filter_key(resource, user_id, key)
    Kredis.hash("#{resource.to_s.underscore}_filters:#{user_id}")[key]
  end
end
