module Tasks
  class SortColumnQuery < Query
    def initialize(relation = Task.all)
      @relation = relation
    end

    def call(params)
      return @relation.order(created_at: :desc) unless params[:sort_deadline_on] || params[:sort_priority]

      if params[:first_sort] == 'sort_deadline_on'
        return @relation.then { |relation| sort_deadline_on(relation, params[:sort_deadline_on]) }
                        .then { |relation| sort_priority(relation, params[:sort_priority]) }
      end

      @relation.then { |relation| sort_priority(relation, params[:sort_priority]) }
               .then { |relation| sort_deadline_on(relation, params[:sort_deadline_on]) }
    end

    private

    def sort_deadline_on(relation, sort_deadline_on)
      return relation if sort_deadline_on.blank?

      sort_deadline_on == 'asc' ? relation.order(deadline_on: :asc) : relation.order(deadline_on: :desc)
    end

    def sort_priority(relation, sort_priority)
      return relation if sort_priority.blank?

      sort_priority == 'asc' ? relation.order(priority: :asc) : relation.order(priority: :desc)
    end
  end
end
