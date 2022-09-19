module Transducers
  module Reducers
    module_function

    def + = lambda { |x, y| x + y }
    def * = lambda { |x, y| x * y }
  end
end
