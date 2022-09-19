RSpec.describe Transducers::Transformers::Filter do
  subject { described_class.with(&fn).call(reducer).call(0, value) }

  let(:fn) { lambda { |x| x > 2 } }
  let(:reducer) { lambda { |x, y| x + y} }

  context 'when value matches predicate' do
    let(:value) { 42 }

    it { is_expected.to eq(42) }
  end

  context 'when value not matches predicate' do
    let(:value) { 1 }

    it { is_expected.to eq(0) }
  end
end
