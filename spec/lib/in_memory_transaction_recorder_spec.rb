require 'in_memory_transaction_recorder'
describe InMemoryTransactionRecorder do
  subject(:transaction_recorder) do
    InMemoryTransactionRecorder.new
  end
  describe '#record' do
    it 'records the transaction made'
  end

  describe '#most_popular_items' do
    it 'returns the most popular item by purchase' do
      transaction_recorder.record(product_number: 'A1', price: 50)
      transaction_recorder.record(product_number: 'A2', price: 50)
      transaction_recorder.record(product_number: 'A3', price: 50)
      
      most_popular_items = transaction_recorder.most_popular_items(3)

      expect(most_popular_items).to eq ['A1', 'A2', 'A3']
    end

    context 'given that only A1 was the the most popular' do
      it 'returns A1 at the top of the ' do
        transaction_recorder.record(product_number: 'A1', price: 50)
        transaction_recorder.record(product_number: 'A2', price: 50)

        most_popular_items = transaction_recorder.most_popular_items(3)

        expect(most_popular_items).to eq ['A1', 'A2']
      end
    end
  end
end
