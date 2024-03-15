require 'active_model'

module ECMBlockchain
  class TokenModel
    include ActiveModel::Validations

    attr_accessor :kind, :quantity, :owner, :transferee

    validates :kind, :quantity, presence: true

    def initialize(data={})
      @kind = data.fetch(:kind)
      @quantity = data.fetch(:quantity)
      @owner = data.fetch(:owner, nil)
      @transferee = data.fetch(:transferee, nil)
      raise error unless valid?
    end
  end
end
