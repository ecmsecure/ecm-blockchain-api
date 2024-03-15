module ECMBlockchain
  class Tokens
    extend ECMBlockchain::Routes
    extend ECMBlockchain::Request

    class << self
      def create(identity, data)
        token(request( :post, "/#{identity}#{TOKENS_URL}/mint", data ))
      end

      def retrieve(identity)
        token(request( :get, "/#{identity}#{TOKENS_URL}" ))
      end

      def update(identity, data)
        token(request( :patch, "/#{identity}#{TOKENS_URL}", data ))
      end

      def revoke(identity)
        response = request( :delete, "/#{identity}#{TOKENS_URL}")
        OpenStruct.new(success: true, details: "Certificate successfully revoked")
      end

      private

      def token(params)
        ECMBlockchain::TokensCollection.new(params)
      end
    end
  end
end
