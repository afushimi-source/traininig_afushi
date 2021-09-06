module TasksHelper
  def sort_order(column, direction, params)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    content = '' if (direction == 'asc' && params[:direction] == 'asc') or (direction == 'desc' && params[:direction] == 'desc')
    link_to content, { column: column, direction: direction }
  end
end
