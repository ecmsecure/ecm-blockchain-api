RSpec.describe ECMBlockchain::DataFile, type: :model do
  subject do
    data = file_response_data 
    ECMBlockchain::DataFile.new(data)
  end

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:identifier) }
  it { is_expected.to respond_to(:base64) }
  it { is_expected.to respond_to(:fileHash) }
  it { is_expected.to respond_to(:storage) }
  it { is_expected.to respond_to(:href) }
  it { is_expected.to respond_to(:digitalSignature) }

  describe '#validations' do
    it { is_expected.to validate_presence_of :identifier } 
    it { is_expected.to validate_presence_of :base64 } 
  end
end
