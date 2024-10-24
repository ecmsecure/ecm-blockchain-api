module RequestHelper
  def asset_request_data
    {
      "uuid": "823737e4-bdc4-401a-b309-ef4c4d4f4733",
      "groupId": "contract-bdc4-401a",
      "title": "signable contract",
      "summary": "updated asset",
      "file": {
        "identifier": "secure MP4",
        "base64": "data:@file/pdf;base64,JVBERi0xLjQKJdPr6eEKMSAwIG9iago8PC9D..."
      },
      "content": {},
    }
  end

  def asset_response_data
    {
      "uuid": "string",
      "title": "string",
      "summary": "string",
      "transactionId": "string",
      "groupId": "string",
      "createdBy": "string",
      "owner": "string",
      "file": {
        "identifier": "string",
        "base64": "string",
        "fileHash": "string",
        "storage": true,
        "digitallySigned": {
          "standard": "simple",
          "signatureType": "certification",
          "cms": "string",
          "timestamp": "string",
          "validated": "string"
        },
        "href": "string"
      },
      "content": {},
      "createdAt": "2024-10-11T09:21:14.246Z",
      "updatedAt": "2024-10-11T09:21:14.246Z"
    }
  end

  def token_response_data 
    {
      kind: "string",
      quantity: 100,
      owner: "string",
      transferee: "string"
    }
  end

  def file_response_data
    {
      identifier: "string",
      base64: "string",
      fileHash: "string",
      storage: true,
      href: "string"
    }
  end

  def digital_signature_response_data
    {
      "standard": "PAdES",
      "signatureType": "certification",
      "cms": "string",
      "timestamp": "string",
      "validated": "string"
    }
  end

  def content_response_data
    {
      test_name: "new asset",
      test_value: "uberbverbveoyfubeou",
      test_access_date: "14-09-2009"
    }
  end

  def error_response_data
    {
      "error": {
        "statusCode": 422,
        "name": "UnprocessableEntityError",
        "message": "The request body is invalid. See error object `details` property for more info.",
        "code": "VALIDATION_FAILED",
        "details": [
          {
            "path": "/file/digitallySigned",
            "code": "required",
            "message": "must have required property 'signatureType'",
            "info": {
              "missingProperty": "signatureType"
            }
          }
        ]
      }
    }
  end

  def success_response_object
      OpenStruct.new(
        success?: true,
        body: {
          success: {
            message: 'success message',
          }
        }.to_json,
        code: 201
      )
  end
 end
