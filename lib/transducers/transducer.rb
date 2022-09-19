require 'transducers/reducers'

module Transducers
  class Transducer
    ReducerNotFound = Class.new(StandardError)

    def initialize(data_structure)
      @data_structure = data_structure
    end

    def transduce(transformer, reducer, seed)
      reducer = reducer_by_name(reducer) if reducer.is_a?(Symbol)
      transformed_reducer = transformer.(reducer)
      @data_structure.reduce(seed) { |acc, el| transformed_reducer.(acc, el) }
    end

    private

    def reducer_by_name(name)
      Reducers.send(name)
    rescue NoMethodError
      candidates = Reducers.singleton_class.public_instance_methods(false)
      raise ReducerNotFound, "cannot find reducer #{name}, did you mean #{candidates.join(', ')}?"
    end
  end
end
