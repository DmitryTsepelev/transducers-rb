module Transducers
  module Transformers
    class TakeWhile < Base
      def initialize(&fn)
        @continue = true
        super
      end

      def build
        lambda do |reducer|
          lambda do |acc, val|
            if @continue && @fn.(val)
              reducer.(acc, val)
            else
              @continue = false
              acc
            end
          end
        end
      end
    end
  end
end
