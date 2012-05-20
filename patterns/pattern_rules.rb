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
