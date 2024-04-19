module ECMBlockchain
  class Tokens
    extend ECMBlockchain::Routes
    extend ECMBlockchain::Request

    class << self
      def create(identity, data)
        token(request( :post, "/#{identity}#{TOKENS_URL}/mint", data ))
      end

      def retrieve(identity, kind='all')
        token(request( :get, "/#{identity}#{TOKENS_URL}/#{kind}" ))
      end

      def total_supply()
        token(request( :get, "/#{TOKENS_URL}"))
      end

      def burn(identity, data)
        response = request( :delete, "/#{identity}#{TOKENS_URL}/burn", data)
        OpenStruct.new(success: true, details: "Tokens successfully burnt")
      end

      def transfer(from, to, data)
        data[:transferee] = request( :get, "/#{to}#{TOKENS_URL}/wallet")
        token(request( :patch, "/#{from}#{TOKENS_URL}/transfer", data ))
      end

      private

      def token(params)
        ECMBlockchain::TokensCollection.new(params)
      end
    end
  end
end
