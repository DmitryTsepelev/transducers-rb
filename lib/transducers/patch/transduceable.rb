require 'transducers/composers/block_composer'
require 'transducers/composers/chain_composer'
require 'transducers/transducer'

module Transducers
  module Patch
    module Transduceable
      def transduce(reducer, seed, &block)
        transformer = Composers::BlockComposer.compose(&block)
        Transducer.new(self).transduce(transformer, reducer, seed)
      end

      def compose
        Composers::ChainComposer.new(self)
      end

      Array.include(Transduceable)
      Hash.include(Transduceable)
    end
  end
end
