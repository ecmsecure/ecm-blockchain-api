RSpec.describe ECMBlockchain::Request do
  before { stub_request(:get, ECMBlockchain.base_url + ECMBlockchain::Routes::MEMBERS_URL) }

  let(:request_class) do
    class Test
      extend ECMBlockchain::Request
    end
  end

  let(:verb) { :post }
  let(:url)  { ECMBlockchain::Routes::MEMBERS_URL }
  let(:header) do
    { "Authorization" => "Bearer abc123", "Content-Type" => "application/json" }  
  end
  let(:data) { "" }

  describe '#request' do
    context 'on failure' do
      it 'should throw an error if no API key' do
        ECMBlockchain.access_token = ''
        expect{ request_class.request(verb, url, data) }
          .to raise_error(ECMBlockchain::Unauthorized)
      end

      it 'should throw an error if the method isnt included' do
        expect{ request_class.request(:wrong, url, data) }
          .to raise_error(ECMBlockchain::BadRequest)
      end

      it 'should have an error message of 400' do
        request_class.request(:wrong, url, data) 
      rescue ECMBlockchain::BadRequest => err
        expect(err.code).to eq(400)
      end

      it 'should call api_client' do
        allow(request_class).to receive(:api_client_call)
          .and_return(OpenStruct.new(success?: true))
        expect(request_class).to receive(:api_client_call)
        request_class.request(verb, url, data)
      end

      it 'should raise an error if success? not true' do
        error = error_response_object
        error.code = 422
        allow(request_class).to receive(:api_client_call)
          .and_return(error)
        expect{request_class.request(verb, url, data)}
          .to raise_error(ECMBlockchain::UnprocessableEntity)
      end
    end

    context 'on success' do
      it 'should return a hash of the response body' do
        allow(request_class).to receive(:api_client_call)
          .and_return(success_response_object)
        expect(request_class.request(verb, url, data)).to be_a(Hash)
      end

      it 'should return contain the success message' do
        allow(request_class).to receive(:api_client_call)
          .and_return(success_response_object)
        expect(request_class.request(verb, url, data)[:success][:message])
          .to eq('success message')
      end
    end
  end
end
