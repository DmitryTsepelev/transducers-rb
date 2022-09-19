module Transducers
  module Transformers
    class Base
      def self.with(&fn)
        new(&fn).build
      end

      def initialize(&fn)
        @fn = fn
      end

      def build
        raise NotImplementedError
      end
    end
  end
end
