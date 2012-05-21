class PatternRules < Ruleby::Rulebook
  def rules
    name :match_input_elements

    [TextBoxDatePattern, MultiTextBoxDatePattern, MultiSelectDatePattern,
       SingleMonthCalendarPattern, SingleYearCalendarPattern].each do |pattern_klass|
          rule [UiModel::DateEntryField, :m],
               [pattern_klass, :p],
               [Matches, :ms] do |v|
            assert(match = Match.new(v[:m], v[:p], 0))
            v[:ms].add(v[:m], match)
          end
       end

    name :small_viewport_textbox
    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(0,29) }],
      [Match, :m, where{
        self.pattern.is?(TextBoxDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    name :small_viewport_multiselect
    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(0,29) }],
       [Match, :m, where{
        self.pattern.is?(MultiSelectDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(30,75) }],
       [Match, :m, where{
        self.pattern.is?(MultiTextBoxDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(30,75) }],
       [Match, :m, where{
        self.pattern.is?(SingleMonthCalendarPattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(76,100) }],
       [Match, :m, where{ 
          self.pattern.is?(MultiTextBoxDatePattern)
          self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(76,100) }],
       [Match, :m, where{
        self.pattern.is?(SingleMonthCalendarPattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.view_port_size.between?(76,100) }],
       [Match, :m, where{
        self.pattern.is?(SingleYearCalendarPattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(0,32) }],
      [Match, :m, where{
        self.pattern.is?(MultiSelectDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(0,32) }],
      [Match, :m, where{
        self.pattern.is?(SingleMonthCalendarPattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(0,32) }],
      [Match, :m, where{
        self.pattern.is?(SingleYearCalendarPattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(33,65) }],
      [Match, :m, where{
        self.pattern.is?(MultiSelectDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(33,65) }],
      [Match, :m, where{
        self.pattern.is?(SingleMonthCalendarPattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(66,100) }],
      [Match, :m, where{
        self.pattern.is?(TextBoxDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end

    rule [Constraints::Constraint, :c, where{ self.user_skill_level.between?(66,100) }],
      [Match, :m, where{
        self.pattern.is?(MultiTextBoxDatePattern)
        self.model_instance.is?(UiModel::DateEntryField)
    }] do |v|
      v[:m].increase_rank
    end
  end
end

