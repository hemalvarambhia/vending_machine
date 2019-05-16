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
      most_popular_items = transaction_recorder.most_popular_items(3)

      expect(most_popular_items).to eq ['A1', 'A2', 'A3']
    end
  end
end
