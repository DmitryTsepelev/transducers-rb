module Transducers
  module Transformers
    class Filter < Base
      def build
        lambda do |reducer|
          lambda { |acc, val| @fn.(val) ? reducer.(acc, val) : acc }
        end
      end
    end
  end
end
