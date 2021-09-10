module TasksHelper
  def generate_sort_param(column, direction)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    link_to content, { "#{column}": direction }
  end
end
