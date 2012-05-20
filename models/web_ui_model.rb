module WebModel
  class ModelElement
    attr_accessor :name
    def initialize(opts)
      @name = opts.delete(:name)
    end
  end
end
