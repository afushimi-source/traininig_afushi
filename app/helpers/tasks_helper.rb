module TasksHelper
  def sort_column(column, direction)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    link_to content, { "#{column}": direction }
  end
end
