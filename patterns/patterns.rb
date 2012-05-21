class TransformationRule
end

class Pattern
  attr_accessor :usability_rank,
                :estimated_width,
                :estimated_height,
                :name,
                :mapped_to

  def initialize(opts)
    @mapped_to = opts[:for]
  end

  def build_transformation_rule
    lambda{|model_instance| target_class_name.new(:name => model_instance.name)}
  end

  def to_s
    "#{self.class}"
  end
end

class TextBoxDatePattern < Pattern
  def target_class_name
    WebModel::TextBox
  end
end

class MultiTextBoxDatePattern < Pattern
  def target_class_name
    WebModel::MultiTextBoxDate
  end
end

class MultiSelectDatePattern < Pattern
  def target_class_name
    WebModel::MultiSelectBoxDate
  end
end

class SingleMonthCalendarPattern < Pattern
  def target_class_name
    WebModel::SingleMonthCalendar
  end
end

class SingleYearCalendarPattern < Pattern
  def target_class_name
    WebModel::SingleYearCalendar
  end
end
