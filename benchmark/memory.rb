$:.push File.expand_path("lib", __dir__)

require "memory_profiler"
require 'transducers'

def run_with_memory_report(section_name)
  print "\n"
  print "#{ "-" * section_name.length}\n"
  print "#{section_name.to_s.ljust(50)}\n"
  print "#{ "-" * section_name.length}\n"
  print "\n"

  print(
    MemoryProfiler.report do
      yield
    end.pretty_print,
  )
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

def run_example(size, transducers:)
  run_with_memory_report("#{transducers ? 'Transducers' : 'Chain'}, size: #{size} ") do
    array = size.times.map { rand(0..10000000) }

    if transducers
      run_with_transducers(array)
    else
      run_without_transducers(array)
    end
  end
end

[100_000, 1_000_000].each do |size|
  run_example(size, transducers: false)
  run_example(size, transducers: true)
end
