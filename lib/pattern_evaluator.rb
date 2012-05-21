class Matches
  attr_accessor :matches

  def initialize
    @matches = {}
  end

  def add(model_element, match)
    (@matches[model_element] ||= [] ) << match
  end

  def matches_for(element)
    @matches[element].sort_by(&:rank).reverse
  end

  def best_match_for(element)
    matches_for(element).first
  end

  def print_ranks
    @matches.each do |element, element_matches|
      element_matches.each do |em|
        puts em
      end
    end
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

  def to_s
    "#{model_instance} : #{pattern} : #{rank}"
  end
end

class PatternEvaluator
  include Ruleby

  def initialize(rules_class)
    @rules_class = rules_class
  end

  def run(models, patterns, constraints)
    ctx = Matches.new
    engine :engine do |e|
      @rules_class.new(e).rules
      e.assert(ctx)
      e.assert(constraints)
      models.each { |m| e.assert m }
      patterns.each { |p| e.assert p }
      e.match
    end
    ctx
  end
end
