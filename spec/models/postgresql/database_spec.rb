require 'rails_helper'

RSpec.describe PostgreSQL::Database, stub_api: true do
  let(:deployment) { Deployment.find $deployment_id }
  let(:database) { PostgreSQL::Database.new name: 'postgres', deployment: deployment }

  describe '#tables' do
    it "should assign schema" do
      expect(database.tables[0].schema).not_to be_nil
    end
  end

end
