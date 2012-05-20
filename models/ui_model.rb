module UiModel
  class ModelElement
    attr_accessor :name
    def initialize(opts)
      @name = opts.delete(:name)
    end

    def to_s
      "%s(%s)" % [name, self.class.name]
    end
  end

  class DateEntryField < ModelElement
  end
end
