module ECMBlockchain
  class DigitalSignature
    include ActiveModel::Validations

    attr_accessor :standard, :signatureType
    attr_reader :cms, :timestamp, :validated

    validates :standard, :signatureType, presence: true
    validates :signatureType, inclusion: { in: %w(certification approval)}
    validates :standard, inclusion: { in: %w(simple PAdES XAdES CAdES)}

    def initialize(data={})
      data ||= {}
      @standard = data[:standard]
      @signatureType = data[:signatureType]
      @cms = data[:cms]
      @validated = data[:validated]
      @timestamp = data[:timestamp]
    end

    def added?
      self.valid?
    end
  end
end
