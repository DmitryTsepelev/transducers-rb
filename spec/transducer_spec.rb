RSpec.describe Transducers::Transducer do
  subject { transducer.transduce(transformer, reducer, seed) }

  let(:transducer) { described_class.new(data_structure) }
  let(:data_structure) { [1, 3, 5] }
  let(:transformer) do
    Transducers::Transformers::Map.with { |el| el + 2 }
  end
  let(:reducer) { lambda { |x, y| x + y } }
  let(:seed) { 3 }

  it { is_expected.to eq((1 + 2) + (3 + 2) + (5 + 2) + 3) }

  context 'when reducer is symbol' do
    let(:reducer) { :* }

    it { is_expected.to eq((1 + 2) * (3 + 2) * (5 + 2) * 3) }

    context 'when symbol not exists in reducers' do
      let(:reducer) { :/ }

      specify do
        expect { subject }.to raise_error(
          described_class::ReducerNotFound,
          'cannot find reducer /, did you mean *, +?'
        )
      end
    end
  end
end
