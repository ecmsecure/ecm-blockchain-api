RSpec.describe ECMBlockchain::Asset, type: :model do
  subject do
    data = asset_response_data 
    ECMBlockchain::AssetModel.new(data)
  end

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to respond_to(:uuid) }
  it { is_expected.to respond_to(:txId) }
  it { is_expected.to respond_to(:groupId) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:summary) }
  it { is_expected.to respond_to(:owner) }
  it { is_expected.to respond_to(:createdBy) }
  it { is_expected.to respond_to(:file) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:access) }
  it { is_expected.to respond_to(:lastInteraction) }

  describe '#validations' do
    it { is_expected.to validate_presence_of :uuid } 
    it { is_expected.to validate_presence_of :title } 

    it 'should error if a file object or content object hasnt been added' do
      subject.file = ECMBlockchain::DataFile.new
      subject.content = ECMBlockchain::DataContent.new
      expect(subject).to_not be_valid
    end

    it 'should error if the file object is not valid' do
      subject.file = ECMBlockchain::DataFile.new
      expect(subject).to_not be_valid
    end

    it 'should error if the file object is not valid' do
      subject.file = ECMBlockchain::DataFile.new
      subject.content = ECMBlockchain::DataContent.new
      expect(subject).to_not be_valid
    end

    it 'should be valid if the file is valid' do
      subject.file = ECMBlockchain::DataFile.new(file_response_data)
      expect(subject).to be_valid
    end
  end
end
