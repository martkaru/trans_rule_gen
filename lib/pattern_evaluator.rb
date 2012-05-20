class Matches
  attr_accessor :matches

  def initialize
    @matches = {}
  end

  def add(model_element, match)
    (@matches[model_element] ||= [] ) << match
  end

  def matches_for(element)
    @matches[element].sort_by(&:rank)
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

class PatternRules < Ruleby::Rulebook
  def rules
    name :match_input_elements
    rule [UiModel::DateEntryField, :m],
         [TextBoxDatePattern, :p],
         [Matches, :ms] do |v|
      assert(match = Match.new(v[:m], v[:p], 0))
      v[:ms].add(v[:m], match)
    end

    rule [Match, :m, where{
        (self.pattern.class == TextBoxDatePattern) &&
        (self.model_instance.class == UiModel::DateEntryField) }
    ] do |v|
      v[:m].increase_rank
    end

    rule [Match, :m, where{
        (self.pattern.class == MultiTextBoxDatePattern) &&
        (self.model_instance.class == UiModel::DateEntryField) }
    ] do |v|
      v[:m].increase_rank
    end

    rule [Match, :m, where{
        (self.pattern.class == MultiSelectDatePattern) &&
        (self.model_instance.class == UiModel::DateEntryField) }
    ] do |v|
      v[:m].increase_rank
    end

    rule [Match, :m, where{
        (self.pattern.class == SingleMonthCalendarPattern) &&
        (self.model_instance.class == UiModel::DateEntryField) }
    ] do |v|
      v[:m].increase_rank
    end

    rule [Match, :m, where{
        (self.pattern.class == SingleYearCalendarPattern) &&
        (self.model_instance.class == UiModel::DateEntryField) }
    ] do |v|
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
