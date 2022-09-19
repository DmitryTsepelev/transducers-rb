$:.push File.expand_path("lib", __dir__)

require 'benchmark'
require 'transducers'

# From https://stackoverflow.com/a/20640938/838346
def without_gc
  GC.start # start out clean
  GC.disable
  yield
  GC.enable
end

def run_without_transducers(array)
  array.map { |x| x + 1 }
    .map { |x| x * 2 }
    .map { |x| x + 1 }
    .map { |x| x * 2 }
    .filter { |x| x > 10000}
    .map { |x| x + 1 }
    .map { |x| x * 2 }
    .map { |x| x + 1 }
    .map { |x| x * 2 }
    .filter { |x| x > 1000}
end

def run_with_transducers(array)
  array.transduce(:+, 0) do
    map { |x| x + 1 }
    map { |x| x * 2 }
    map { |x| x + 1 }
    map { |x| x * 2 }
    filter { |x| x > 10000}
    map { |x| x + 1 }
    map { |x| x * 2 }
    map { |x| x + 1 }
    map { |x| x * 2 }
    filter { |x| x > 1000}
  end
end

def run_example(bm, size, gc:, transducers:)
  array = size.times.map { rand(0..10000000) }

  bm.report("#{transducers ? 'Transducers' : 'Chain'}, gc = #{gc}, size: #{size} ") do
    if gc
      if transducers
        run_with_transducers(array)
      else
        run_without_transducers(array)
      end
    else
      without_gc do
        if transducers
          run_with_transducers(array)
        else
          run_without_transducers(array)
        end
      end
    end
  end
end

Benchmark.bm(50) do |bm|
  [10_000, 100_000, 1_000_000, 10_000_000].each do |size|
    [true, false].each do |gc|
      run_example(bm, size, gc: gc, transducers: false)
      run_example(bm, size, gc: gc, transducers: true)
    end
  end
end
