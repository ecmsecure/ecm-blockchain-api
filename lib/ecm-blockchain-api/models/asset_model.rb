require 'active_model'
require 'json'

module ECMBlockchain
  class AssetModel
    include ActiveModel::Validations

    attr_accessor :uuid, :txId, :groupId, :title, :summary, :createdBy, :owner,
                  :file, :content, :created_at, :access, :lastInteraction, :events

    validates :uuid, :title, presence: true
    validate :data_file_or_content?
 
    class << self
      def verify(data={})
        asset = self.new(data)
        raise ECMBlockchain::Error.raise_error(
          OpenStruct.new(
            code: 422, 
            body: { 
              error: { 
                message: asset.errors.full_messages.first,
                details: ''
              }
            }.to_json 
          )
        ) unless asset.valid?
        asset
      end
    end

    def initialize(data={})
      @uuid = data.fetch(:uuid) { nil }
      @txId = data.fetch(:txId) { nil }
      @groupId = data.fetch(:groupId) { nil }
      @title = data.fetch(:title) { nil }
      @summary = data.fetch(:summary) { nil }
      @createdBy = data.fetch(:createdBy) { nil }
      @owner = data.fetch(:owner) { nil }
      @file = ECMBlockchain::DataFile.new(data.fetch(:file) { })
      @content = ECMBlockchain::DataContent.new(data.fetch(:content) { })
    end

    def success?
      true
    end

    def error
      nil
    end

    private

    def data_file_or_content?
      unless file.valid? || content.valid?
        errors.add(:base, 
          "file or content error: #{file.errors.full_messages.first || content.errors.full_messages.first ||
          "Please supply either a file object or content object"}"
        )
      end
    end
  end
end
