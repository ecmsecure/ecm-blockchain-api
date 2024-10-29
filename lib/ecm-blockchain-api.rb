# frozen_string_literal: true

require_relative "ecm-blockchain-api/version"
require_relative "ecm-blockchain-api/client"
require_relative "ecm-blockchain-api/routes"
require_relative "ecm-blockchain-api/request"
require_relative "ecm-blockchain-api/errors"
require_relative "ecm-blockchain-api/models/member"
require_relative "ecm-blockchain-api/models/asset_model"
require_relative "ecm-blockchain-api/models/token_model"
require_relative "ecm-blockchain-api/models/token_collection"
require_relative "ecm-blockchain-api/models/data_file_model"
require_relative "ecm-blockchain-api/models/data_content_model"
require_relative "ecm-blockchain-api/models/custom_attribute"
require_relative "ecm-blockchain-api/models/digital_signature_model"
require          "httparty"
require          "logger"
require          "active_model"

require  "ecm-blockchain-api/ca"
require  "ecm-blockchain-api/asset"
require  "ecm-blockchain-api/token"

module ECMBlockchain
  require "pry"

  class << self
    attr_accessor :access_token, :logger, :base_url
    
    def has_api_key?
      return unless ECMBlockchain.access_token.to_s.empty?
      raise Unauthorized.new( 
        message: "You need to set your access_token", 
        code: 401,
        name: Unauthorized)  
    end
  end

  @logger = Logger.new(STDOUT)
  @base_url = "https://api.ecmsecure.com/v1"
end
