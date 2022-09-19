require 'transducers/transformers/base'
require 'transducers/transformers/filter'
require 'transducers/transformers/map'
require 'transducers/transformers/take_while'

module Transducers
  module Composers
    class BlockComposer
      class << self
        def register(method_name, transformer)
          define_method(method_name) do |*args, &fn|
            reducers << transformer.with(*args, &fn)
            self
          end
        end

        def compose(&block)
          new.tap { |composer| composer.instance_eval(&block) }.compose
        end
      end

      register :map, Transformers::Map
      register :filter, Transformers::Filter
      register :take_while, Transformers::TakeWhile

      def compose
        reducers.reverse.reduce do |acc, val|
          lambda { |args| val.(acc.(args)) }
        end
      end

      private

      def reducers
        @reducers ||= []
      end
    end
  end
end
