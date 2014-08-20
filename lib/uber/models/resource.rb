module Uber
  class Resource
    def initialize(hash)
      hash.each do |name, value|
        instance_variable_set "@#{name}", value
      end
    end
  end
end