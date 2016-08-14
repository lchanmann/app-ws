RSpec.shared_examples "raise Errors::NotFound" do |message|
  it { expect(response.status).to eq(404) }
  it { expect(response).to render_template("errors/not_found") }

  describe 'display error message' do
    render_views
    it { expect(response.body).to match /#{message}/ }
    it { expect(response).to render_template("megatron/errors") }
  end
end
