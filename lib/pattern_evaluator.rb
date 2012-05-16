class Matches
  attr_accessor :matches

  def initialize
    @matches = {}
  end

  def add(model_element, match)
    (@matches[model_element] ||= [] ) << match
  end
end

class Match
  attr_accessor :model_instance, :pattern, :rank
  def initialize(*args)
    @model_instance, @pattern, @rank  = *args
  end
end

class PatternRules < Ruleby::Rulebook
  def rules
    name :transform_input_element
    rule [InputField, :m, where {|m| m.secure }],
         [Pattern, :p],
         [Matches, :c] do |v|
      v[:c].add(v[:m], Match.new(v[:m], v[:p], 0))
    end
  end
end

class PatternEvaluator
  include Ruleby
  def run(models, patterns)
    ctx = Matches.new
    engine :engine do |e|
      PatternRules.new(e).rules
      e.assert(ctx)
      models.each { |m| e.assert m }
      patterns.each { |p| e.assert p }
      e.match
    end
    ctx
  end
end
