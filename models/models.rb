class ModelElement
  attr_accessor :name
end

class InputField < ModelElement
  attr_accessor :secure
  def initialize(opts)
    @name = opts.delete(:name)
    @secure = !!opts.delete(:secure)
  end
end
