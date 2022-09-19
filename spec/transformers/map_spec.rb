RSpec.describe Transducers::Transformers::Map do
  subject { described_class.with(&fn).call(reducer).call(0, value) }

  let(:fn) { lambda { |x| x + 1 } }
  let(:reducer) { lambda { |x, y| x + y } }
  let(:value) { 42 }

  it { is_expected.to eq(43) }
end
