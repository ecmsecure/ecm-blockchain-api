RSpec.describe ECMBlockchain::Error do
  before do
    @error = ECMBlockchain::Error.new
  end
  describe "#initialize" do
    context "creating an instance" do
      it 'should create an instance with default params' do
        expect(@error.code).to be_nil
        expect(@error.message).to eq("")
        expect(@error.details).to be_nil
        expect(@error.name).to be_nil
      end

      it 'should create an instance with the correct info' do
        @error = ECMBlockchain::UnprocessableEntity.new(
          message: "A test",
          code: 422,
          details: ["log of errors"],
          name: ECMBlockchain::UnprocessableEntity.to_s
        )

        expect(@error.code).to eq(422)
        expect(@error.message).to eq("A test")
        expect(@error.details).to include("log of errors")
        expect(@error.name).to eq("ECMBlockchain::UnprocessableEntity")
        expect(@error).to be_a(ECMBlockchain::Error)
      end
    end
  end

  describe '.raise_error' do
    let(:response) do
      error_response_object
    end

    it 'should raise a BadRequest error' do
      expect{ECMBlockchain::Error.raise_error(response)}
        .to raise_error(ECMBlockchain::BadRequest)
    end

    it 'should raise an ECMBlockchain::Error if no class found' do
      response.code = 700
      expect{ECMBlockchain::Error.raise_error(response)}
        .to raise_error(ECMBlockchain::Error)
    end
  end
end
