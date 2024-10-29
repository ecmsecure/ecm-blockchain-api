module ECMBlockchain
  class DataFile
    include ActiveModel::Validations

    attr_accessor :identifier, :base64, :storage, :digitalSignature
    attr_reader :fileHash, :href

    validates :identifier, :base64, presence: true

    def initialize(data={})
      data ||= {}
      @identifier = data[:identifier]
      @base64 = data[:base64]
      @storage = data[:storage]
      @fileHash = data[:fileHash]
      @href = data[:href]
      @digitalSignature = ECMBlockchain::DigitalSignature.new(data.fetch(:digitalSignature) {})
    end

    def added?
      self.valid?
    end
  end
end
