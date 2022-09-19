# Transducers

Experimental transducer implementation for Ruby.

```ruby
array = [1, 4, 7]

result = array.transduce(:+, 0) do
  map { |el| el + 1 }
  take_while { |el| el < 7 }
  filter(&:odd?)
end

puts result.inspect

result2 = array.compose
  .map { |el| el + 1 }
  .take_while { |el| el < 7 }
  .filter(&:odd?)
  .transduce(:+, 0)

puts result2.inspect

hash = { a: 1, b: 2 }
result3 = hash.compose
  .map { |(_, value)| value + 1 }
  .transduce(:+, 0)

puts result3.inspect
```

## How it works

Regular enumberable methods are not lazy and perform loop over the collection everytime one of them is called. When methods are changed Ruby creates new instance of the enumerable and consumes more memory because new objects are allocated.

Transducers are lazy: when multiple functions are called, they produce a single function that perform a single action on each element of the collection, therefore new colection is created only once.

In order to use them we have to use the `transduce` function:

```ruby
array.transduce(:+, 0) do
  # DSL for manipulating the collection is here
  map { |el| el + 1 }
  take_while { |el| el < 7 }
  filter(&:odd?)
end
```

Alternatively, we can use chaining via the `compose` function:

```ruby
array.compose
  # instructions how to manipulate the collection start here
  .map { |el| el + 1 }
  .take_while { |el| el < 7 }
  .filter(&:odd?)
  # evaluation performed here
  .transduce(:+, 0)
```

## Benchmarks

How to read:

- _chain_ means that we perform transformation using regular enumerable methods (`map`, `select`, `reduce` etc.);
- _transducer_ means that we build the transducer and go through the loop once.

### Execution

|Type|GC|Size|Execution|
|-|-|-|-|
|Chain|true|10000|0.002953|
|Transducers|true|10000|0.006204|
|Chain|false|10000|0.006236|
|Transducers|false|10000|0.009610|
|Chain|true|100000|0.028672|
|Transducers|true|100000|0.063582|
|Chain|false|100000|0.032389|
|Transducers|false|100000|0.065613|
|Chain|true|1000000|0.292078|
|Transducers|true|1000000|0.623548|
|Chain|false|1000000|0.286302|
|Transducers|false|1000000|0.611950|
|Chain|true|10000000|2.931744|
|Transducers|true|10000000|6.138606|
|Chain|false|10000000|2.854552|
|Transducers|false|10000000|6.184660|

Trnansducers is 3x slower!

### Memory

|Type|Size|Allocated|
|-|-|-|
|Chain|100000|8.6 MB|
|Transducers|100000|0.9 MB|
|Chain|1000000|87.4 MB|
|Transducers|1000000|11.1 MB|

Consumes way less memory!

## Installation

Add this line to your application's Gemfile, and you're all set:

```ruby
gem "transducers"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
