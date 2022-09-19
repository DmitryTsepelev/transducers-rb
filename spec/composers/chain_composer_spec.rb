RSpec.describe Transducers::Composers::ChainComposer do
  describe '.compose' do
    subject { composer.transduce(reducer, seed) }

    let(:transduceable) { [1, 2] }
    let(:reducer) { :+ }
    let(:seed) { 0 }
    let(:composer) do
      described_class.new(transduceable)
        .filter { |x| x > 1 }
        .map { |x| x + 1 }
    end

    it { is_expected.to eq(3) }
  end
end
