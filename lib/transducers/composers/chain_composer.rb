module Transducers
  module Composers
    class ChainComposer < BlockComposer
      def initialize(data_structure)
        @data_structure = data_structure
      end

      def transduce(reducer, seed)
        Transducer.new(@data_structure).transduce(compose, reducer, seed)
      end
    end
  end
end
