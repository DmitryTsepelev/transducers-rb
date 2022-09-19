RSpec.describe Transducers::Patch::Transduceable do
  CLASSES = [Array, Hash]

  describe 'include' do
    subject { CLASSES.map(&:new) }

    it { is_expected.to all respond_to(:transduce) }
    it { is_expected.to all respond_to(:compose) }
  end

  describe '#transduce' do
    describe 'Array' do
      subject { [2, 3, 5].transduce(reducer, 1) { filter(&:odd?) } }

      let(:reducer) { lambda { |x, y| x + y }}

      it { is_expected.to eq(1 + 3 + 5) }
    end

    describe 'Array' do
      subject { { a: 1, b: 3, c: 5 }.transduce(reducer, 1) { map { |_, x| x + 1 } } }

      let(:reducer) { lambda { |x, y| x + y }}

      it { is_expected.to eq((1 + 1) + (3 + 1) + (5 + 1 + 1)) }
    end
  end

  describe '#compose' do
    CLASSES.each do |klass|
      subject { klass.new.compose }

      describe klass.name do
        it { is_expected.to be_a(Transducers::Composers::ChainComposer) }
      end
    end
  end
end
