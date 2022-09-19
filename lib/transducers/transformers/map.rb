module Transducers
  module Transformers
    class Map < Base
      def build
        lambda do |reducer|
          lambda { |acc, val| reducer.(acc, @fn.(val)) }
        end
      end
    end
  end
end
