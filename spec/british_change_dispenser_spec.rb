# coding: utf-8
require './lib/british_change_dispenser'
describe BritishChangeDispenser do
  describe '#change_for' do
    context '£2' do
      context 'given we have £2 coins' do
        subject(:change_dispenser) { described_class.new(200 => 1) }
        
        it 'returns £2 coin' do
          expect(change_dispenser.change_for(200)).to eq [200]
        end
      end
    end
  end
end
