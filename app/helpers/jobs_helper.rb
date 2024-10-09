module JobsHelper
  def job_status_color(status)
    {
      draft: "bg-amber-50 text-amber-500 ring-amber-400/20",
      open: "bg-green-50 text-green-700 ring-green-600/20",
      closed: "bg-rose-50 text-rose-700 ring-rose-600/20"
    }[status.to_sym]
  end
end
