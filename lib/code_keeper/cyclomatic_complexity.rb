# frozen_string_literal: true

module CodeKeeper
  # Caluculate cyclomatic complexity
  class CyclomaticComplexity
    include ::RuboCop::Cop::Metrics::Utils::IteratingBlock
    include ::RuboCop::Cop::Metrics::Utils::RepeatedCsendDiscount

    CONSIDERED_NODES = %i[if while until for csend block block_pass rescue when and or or_asgnand_asgn].freeze

    def initialize(file_path)
      ps = Parser.parse(file_path)
      @body = ps.ast.body
    end

    # returns score of cyclomatic complexity
    def score
      @body.each_node(:lvasgn, *CONSIDERED_NODES).reduce(1) do |score, node|
        next score if !iterating_block?(node) || node.lvasgn_type?
        next score if node.csend_type? && discount_for_repeated_csend?(node)

        next 1 + score
      end
    end
  end
end
