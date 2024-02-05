RSpec.describe ECMBlockchain::Member, type: :model do
  subject do
    data = {
      "uuid": "user112233@org1.example.com",
      "organisation": "example",
      "certificate": "cert",
      "customAttributes": [
        {
          "name": "verified",
          "value": "true"
        }
      ]
    } 
    ECMBlockchain::Member.new(data)
  end

  it { is_expected.to respond_to(:uuid) }
  it { is_expected.to respond_to(:organisation) }
  it { is_expected.to respond_to(:certificate) }
  it { is_expected.to respond_to(:custom_attributes) }

  describe '#validations' do
    it { is_expected.to validate_presence_of :uuid } 
    it { is_expected.to validate_presence_of :organisation } 
    it { is_expected.to validate_presence_of :certificate } 
  end

  describe '#initialize' do
    let(:member_response) do
      {
        uuid: "user@org1.example.com",
        organisation: "Org1",
        certificate: "-----BEGIN CERTIFICATE REQUEST-----",
        customAttributes: [
          {
            name: "verified",
            value: "true"
          }
        ]
      }
    end

    it 'should create a member with the correct attributes' do
      member = ECMBlockchain::Member.new(member_response)
      expect(member.uuid).to eq(member_response[:uuid])
      expect(member.organisation).to eq(member_response[:organisation])
      expect(member.certificate).to eq(member_response[:certificate])
      expect(member.custom_attributes.length).to eq(member_response[:customAttributes].length)
    end

    it 'should include the attributes' do
      member = ECMBlockchain::Member.new(member_response)
      expect(member.custom_attributes[0]).to be_a(ECMBlockchain::CustomAttribute)
      expect(member.custom_attributes[0].name).to eq("verified")
    end

    it 'should not be valid without a uuid' do
      member_response[:uuid] = ""
      member = ECMBlockchain::Member.new(member_response)
      expect(member).to_not be_valid
    end
  end
end
