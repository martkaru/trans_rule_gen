class Factory
  def self.build_model
    elements = []
    elements << UiModel::DateEntryField.new(:name => 'from')
    elements << UiModel::DateEntryField.new(:name => 'to')
    elements
  end

  def self.build_patterns
    patterns = []
    patterns << TextBoxDatePattern.new(:for => UiModel::DateEntryField)
    patterns << MultiTextBoxDatePattern.new(:for => UiModel::DateEntryField)
    patterns << MultiSelectDatePattern.new(:for => UiModel::DateEntryField)
    patterns << SingleMonthCalendarPattern.new(:for => UiModel::DateEntryField)
    patterns << SingleYearCalendarPattern.new(:for => UiModel::DateEntryField)
    patterns
  end

  def self.build_constraints
    Constraints::Constraint.new(
      :view_port_size => 50,
      :user_skill_level => 50
    )
  end
end
