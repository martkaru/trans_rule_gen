module WebModel
  class ModelElement
    attr_accessor :name
    def initialize(opts)
      @name = opts.delete(:name)
    end
  end

  class TextBox < ModelElement
    def render
      "<input type=\"text\" name=\"#{name}\" value=\"\">"
    end
  end

  class SelectBox < ModelElement
    def render
      "<select name=\"#{name}\"></select>"
    end
  end

  class MultiBoxDate < ModelElement
    def initialize(opts)
      @items = %w(day month year).map{|date_part| box_class.new(:name => date_part) }
    end

    def render
      @items.map(&:render).join('-')
    end
  end

  class MultiTextBoxDate < MultiBoxDate
    def box_class
      TextBox
    end
  end

  class MultiTextBoxDate < MultiBoxDate
    def box_class
      TextBox
    end
  end

  class SingleMonthCalendar < ModelElement
    def render
      "<div class=\"month_calendar\" data-name=\"#{name}\">"
    end
  end

  class SingleYearCalendar < ModelElement
    def render
      "<div class=\"year_calendar\" data-name=\"#{name}\">"
    end
  end
end
