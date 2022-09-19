RSpec.describe Transducers::Composers::BlockComposer do
  describe '.compose' do
    subject { Transducers::Transducer.new(transduceable).transduce(transformer, reducer, seed) }

    let(:transduceable) { [1, 2] }
    let(:reducer) { :+ }
    let(:seed) { 0 }
    let(:transformer) do
      described_class.compose do
        filter { |x| x > 1 }
        map { |x| x + 1 }
      end
    end

    it { is_expected.to eq(3) }
  end

  describe 'registered methods' do
    specify do
      expect(subject.methods).to include(:map, :filter, :take_while)
    end
  end
end
