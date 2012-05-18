class Matches
  attr_accessor :matches

  def initialize
    @matches = {}
  end

  def add(model_element, match)
    (@matches[model_element] ||= [] ) << match
  end

  def matches_for(element)
    @matches[element]
  end

  def best_match_for(element)
    matches_for(element).sort_by(:rank)
  end
end

class Match
  attr_accessor :model_instance, :pattern, :rank
  def initialize(*args)
    @model_instance, @pattern, @rank = *args
  end

  def increase_rank(amount = 1)
    @rank += amount
  end

  def decrease_rank(amount = -1)
    @rank -= amount
  end
end

class PatternRules < Ruleby::Rulebook
  def rules
    name :match_input_elements
    rule [DateEntryField, :m],
         [TextBoxDatePattern, :p],
         [Matches, :ms] do |v|
      assert(match = Match.new(v[:m], v[:p], 0))
      v[:ms].add(v[:m], match)
    end

    name :evaluate_pattern_match
    rule [Match, :m, where{ (self.pattern.class == TextBoxDatePattern) && (self.model_instance.class == DateEntryField) }] do |v|
      v[:m].increase_rank
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
