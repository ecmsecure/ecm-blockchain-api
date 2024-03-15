RSpec.describe ECMBlockchain::TokenModel, type: :model do
  subject do
    data = token_response_data 
    ECMBlockchain::TokenModel.new(data)
  end

  it { is_expected.to respond_to(:kind) }
  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:owner) }
  it { is_expected.to respond_to(:transferee) }

  describe '#validations' do
    it { is_expected.to validate_presence_of :kind } 
    it { is_expected.to validate_presence_of :quantity } 
  end
end
