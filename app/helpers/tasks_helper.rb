module TasksHelper
  ALLOW_TERM_PARAMS_KEYS = %w[sort_deadline_on sort_priority title_term status_term priority_term label_term].freeze

  def generate_status_link(display_text, task)
    link_to display_text, task_path(task.id, params: { task: { status: display_text } }), method: :put, class: (display_text == task.status ? 'link_disabled' : 'link_enabled')
  end

  def generate_sort_param(column, direction)
    content = direction == 'asc' ? '⬆︎' : '⬇︎'
    link_to content, { "sort_#{column}": direction.to_s, first_sort: "sort_#{column}" }.merge!(take_params(submit_key: "sort_#{column}"))
  end

  def take_params_hidden_field_tags(submit_key: nil)
    tags = take_params(submit_key: submit_key).map do |key, value|
      hidden_field_tag(key, value)
    end
    tags.join.html_safe
  end

  def take_params(submit_key: nil)
    tmp = {}
    ALLOW_TERM_PARAMS_KEYS.map { |key| tmp[key] = params[key] if params.keys.include?(key) && submit_key != key }
    tmp
  end

  def from_new_task_to_label
    params[:from_new_task] = true
    link_to 'ラベルを追加する>>', new_label_path(from_task: true)
  end
end
