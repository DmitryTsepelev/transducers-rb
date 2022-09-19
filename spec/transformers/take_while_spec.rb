RSpec.describe Transducers::Transformers::TakeWhile do
  subject { transformer.call(reducer).call(0, value) }

  let(:transformer) { described_class.with(&fn) }
  let(:fn) { lambda { |x| x > 2 } }
  let(:reducer) { lambda { |x, y| x + y} }

  context 'when value matches predicate' do
    let(:value) { 42 }

    it { is_expected.to eq(42) }
  end

  context 'when value not matches predicate' do
    let(:value) { 1 }

    it { is_expected.to eq(0) }

    context 'when next value matches predicate' do
      let(:previous_value) { 1 }
      let(:value) { 42 }

      before { transformer.call(reducer).call(0, previous_value) }

      it { is_expected.to eq(0) }
    end
  end
end
