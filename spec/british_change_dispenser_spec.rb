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

      context 'given we only have £1 coins' do
        subject(:change_dispenser) do
          described_class.new(200 => 0, 100 => 10)
        end
        
        it 'returns 2 £1 coins' do
          expect(change_dispenser.change_for(200)).to eq [100, 100]
        end
      end
    end

    context '£1' do
      context 'given we have £1 coins only' do
        subject(:change_dispenser) do
          described_class.new(200 => 0, 100 => 2)
        end
        
        it 'returns a £1 coin' do
          expect(change_dispenser.change_for(100)).to eq [100]
        end
      end

      context 'given we have £2 and £1 coins only' do
        subject(:change_dispenser) do
          described_class.new(200 => 10, 100 => 2)
        end

        it 'returns a £1 coin' do
          expect(change_dispenser.change_for(100)).to eq [100]
        end
      end
    end

    context '£3' do
      context 'given we have £2 and £1 coins' do
        subject(:change_dispenser) do
          described_class.new(200 => 10, 100 => 2)
        end

        it 'returns a £2 coin and £1' do
          expect(change_dispenser.change_for(300)).to eq [200, 100]
        end
      end
    end
  end
end
