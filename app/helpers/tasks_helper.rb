module TasksHelper
<<<<<<< HEAD
  def sort_order(column, direction)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    link_to content, { column: column, direction: direction, term: params[:term] }
  end

  def generate_status_link(display_text, task)
    link_to display_text, task_path(task.id, params: { task: { status: display_text } }), method: :put, class: (display_text == task.status ? 'link_disabled' : 'link_enabled').to_s
  end
=======
>>>>>>> step16
end
