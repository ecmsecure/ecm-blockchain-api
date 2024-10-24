RSpec.describe ECMBlockchain::DigitalSignature, type: :model do
  subject do
    data = digital_signature_response_data 
    ECMBlockchain::DigitalSignature.new(data)
  end

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:standard) }
  it { is_expected.to respond_to(:signatureType) }
  it { is_expected.to respond_to(:cms) }
  it { is_expected.to respond_to(:timestamp) }
  it { is_expected.to respond_to(:validated) }

  describe '#validations' do
    it { is_expected.to validate_presence_of :standard } 
    it { is_expected.to validate_presence_of :signatureType } 
    it { should validate_inclusion_of(:signatureType).in_array(%w(certification approval)) }
    it { should validate_inclusion_of(:standard).in_array(%w(simple PAdES XAdES CAdES)) }
  end
end
