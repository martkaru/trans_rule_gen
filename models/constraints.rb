module Constraints
  class Constraint
    attr_accessor :user_skill_level, :view_port_size
    def initialize(opts)
      opts.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end
end
