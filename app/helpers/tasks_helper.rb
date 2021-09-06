module TasksHelper
  def generate_status_link(display_text, task)
    link_to display_text, task_path(task.id, params: { task: { status: display_text } }), method: :put, class: (display_text == task.status ? 'link_disabled' : 'link_enabled').to_s
  end
end
