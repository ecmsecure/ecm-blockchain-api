module ECMBlockchain
  class Error < StandardError
    attr_reader :code, :details, :name

    def self.raise_error(response)
      klass = ERROR_CLASS_MAP[response.code] || self
      res = response.body
      res = '{}' if res == ''
      err = JSON.parse(res).deep_symbolize_keys[:error]
      raise klass.new(
        message: err[:message] || response.headers["status"], 
        code: err[:statusCode] || response.code, 
        details: err[:details], 
        name: klass.to_s
      )
    end

    # Initializes a new Error object
    #
    # @param message [Exception, String]
    # @param code [Integer]
    # @return [ECMBlockchain::Error]
    def initialize(message: "", code: nil, details: nil, name: nil)
      super(message)

      @code = code
      @details = details
      @name = name
    end
  end

  class BadRequest < ECMBlockchain::Error;end;
  class Unauthorized < ECMBlockchain::Error; end; 
  class PaymentRequired < ECMBlockchain::Error; end; 
  class Forbidden < ECMBlockchain::Error; end; 
  class RequestEntityTooLarge < ECMBlockchain::Error; end; 
  class NotFound < ECMBlockchain::Error; end; 
  class NotAcceptable < ECMBlockchain::Error; end; 
  class UnprocessableEntityError < ECMBlockchain::Error; end; 
  class TooManyRequests < ECMBlockchain::Error; end; 
  class ServerError < ECMBlockchain::Error; end; 
  class InternalServerError < ECMBlockchain::Error; end; 
  class BadGateway < ECMBlockchain::Error; end; 
  class ServiceUnavailable < ECMBlockchain::Error; end; 
  class GatewayTimeout < ECMBlockchain::Error; end; 
  class TimeoutError < ECMBlockchain::Error; end; 

  ERROR_CLASS_MAP = {
    400 => ECMBlockchain::BadRequest,
    401 => ECMBlockchain::Unauthorized,
    402 => ECMBlockchain::PaymentRequired,
    403 => ECMBlockchain::Forbidden,
    404 => ECMBlockchain::NotFound,
    406 => ECMBlockchain::NotAcceptable,
    413 => ECMBlockchain::RequestEntityTooLarge,
    422 => ECMBlockchain::UnprocessableEntityError,
    429 => ECMBlockchain::TooManyRequests,
    500 => ECMBlockchain::InternalServerError,
    502 => ECMBlockchain::BadGateway,
    503 => ECMBlockchain::ServiceUnavailable,
    504 => ECMBlockchain::GatewayTimeout,
  }.freeze

end
