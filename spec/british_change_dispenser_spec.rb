# coding: utf-8
require './lib/british_change_dispenser'
describe BritishChangeDispenser do
  describe '#dispense' do
    context '£1' do
      context 'given the dispenser has £1 total in change initially' do
        subject(:change_dispenser) do
          described_class.new(100 => 1)
        end

        let(:expected) do
          {
            100 => 0,
          }
        end
        
        it 'dispenses £1 and 50p, leaving £1.50 remaining' do
          change_dispenser.dispense(100)
          expect(change_dispenser.amount_of_change).to eq expected
        end
      end
    end
  end

  
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

    context '£1.30' do
      context 'given we have £1, 20p and 10p coins available' do
        subject(:change_dispenser) do
          described_class.new(100 => 2, 20 => 10, 10 => 4)
        end

        let(:expected) { [100, 20, 10] }
        
        it 'returns the correct change' do
          expect(change_dispenser.change_for(130)).to eq expected
        end
      end
    end

    context '£3.88' do
      context 'given we have the necessary coins available' do
        subject(:change_dispenser) do
          described_class.new(
            200 => 1000,
            100 => 2,
            50 => 50,
            20 => 10,
            10 => 4,
            5 => 10,
            2 => 75,
            1 => 1000
          )
        end

        let(:expected) do
          [200, 100, 50, 20, 10, 5, 2, 1]
        end

        it 'returns the correct change' do
          expect(change_dispenser.change_for(388)).to eq expected
        end
      end
    end

    context '£5.85' do
      context 'given we have the necessary coins available' do
        subject(:change_dispenser) do
          described_class.new(
            200 => 1000,
            100 => 2,
            50 => 50,
            20 => 10,
            10 => 4,
            5 => 10,
            2 => 75,
            1 => 1000
          )
        end

        let(:expected) do
          [200, 200, 100, 50, 20, 10, 5]
        end

        it 'returns the correct change' do
          expect(change_dispenser.change_for(585)).to eq expected
        end
      end
    end
  end
end
