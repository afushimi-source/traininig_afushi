module TasksHelper
  def sort_order(column, direction)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    link_to content, { column: column, direction: direction }
  end
end
