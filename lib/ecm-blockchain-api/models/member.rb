require 'active_model'

module ECMBlockchain
  class Member
    include ActiveModel::Validations

    attr_accessor :uuid, :organisation, :reference, :certificate

    validates :uuid, presence: true
    validates :organisation, :certificate, presence: true

    def initialize(data={})
      @uuid = data.fetch(:uuid)
      @organisation = data.fetch(:organisation)
      @certificate = data.fetch(:certificate)
      @reference = data.fetch(:reference, nil)
    end
  end
end
