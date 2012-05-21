class Transformer
  def initialize
    @evaluator = PatternEvaluator.new(PatternRules)
    @patterns = Factory.build_patterns
  end 

  def transform(model, constraints)
    transformation_rules = @evaluator.run(model, @patterns, constraints)
    model.map do |model_element|
      transformation_rule = transformation_rules.best_match_for(model_element).pattern.build_transformation_rule
      transformation_rule.call(model_element)
    end
  end
end
