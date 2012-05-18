class Transformation
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

  def build_transformation_rule(model_instance)
    Transformation.new
  end
end

class TextBoxDatePattern < Pattern
end

class MultiTextBoxDatePattern < Pattern
end

class MultiSelectDatePattern < Pattern
end

class SingleMonthCalendarPattern < Pattern
end

class SingleYearCalendarPattern < Pattern
end
