module ECMBlockchain
  class TokensCollection

    include Enumerable
    attr_accessor :tokens

    def initialize(tokens=[])
      self.tokens = tokens.map do |token|
        ECMBlockchain::TokenModel.new(token)
      end
    end

    def each(&block)
      self.tokens.each(&block)
    end
  end
end
