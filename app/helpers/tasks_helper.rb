module TasksHelper
  ALLOW_TERM_PARAMS_KEYS = %w(sort_deadline_on sort_priority title_term status_term priority_term)

  def generate_status_link(display_text, task)
    link_to display_text, task_path(task.id, params: { task: { status: display_text } }), method: :put, class: (display_text == task.status ? 'link_disabled' : 'link_enabled')
  end

  def generate_sort_param(column, direction)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    link_to content, { "sort_#{column}": "#{direction}", first_sort: "sort_#{column}" }.merge!(take_params("sort_#{column}"))
  end

  def take_params_hidden_field_tags(param_keys = '')
    tags = take_params(param_keys).map do |key, value|
      hidden_field_tag(key, value)
    end
    tags.join.html_safe
  end

  def take_params(submit_keys = '')
    tmp = {}
    ALLOW_TERM_PARAMS_KEYS.each { |key| tmp[key] = params[key] if params.keys.include?(key) && submit_keys != key }
    tmp
  end
end
