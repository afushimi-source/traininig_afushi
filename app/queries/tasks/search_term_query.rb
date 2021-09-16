module Tasks
  class SearchTermQuery < Query
    def initialize(relation = Task.all)
      @relation = relation
    end

    def call(params)
      return @relation unless params[:title_term] || params[:status_term] || params[:priority_term]

      @relation.then { |relation| search_by_title(relation, params[:title_term]) }
               .then { |relation| search_by_status(relation, params[:status_term]) }
               .then { |relation| search_by_priority(relation, params[:priority_term]) }
    end

    private

    def search_by_title(relation, title_term)
      return relation if title_term.blank?

      relation.where('title LIKE ?', "%#{title_term}%")
    end

    def search_by_status(relation, status_term)
      status_term = Task.statuses.keys.include?(status_term) ? Task.statuses[status_term] : nil
      return relation if status_term.blank?

      relation.where('status = ?', status_term)
    end

    def search_by_priority(relation, priority_term)
      priority_term = Task.priorities.keys.include?(priority_term) ? Task.priorities[priority_term] : nil
      return relation if priority_term.blank?

      relation.where('priority = ?', priority_term)
    end
  end
end
