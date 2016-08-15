require 'rails_helper'

RSpec.describe PostgreSQL::Database, stub_api: true do
  let(:deployment) { Deployment.find $deployment_id }
  let(:database) { PostgreSQL::Database.new name: 'postgres', deployment: deployment }

  describe '#tables' do
    it "should assign schema" do
      expect(database.tables[0].schema).not_to be_nil
    end

    context 'rows_count stat' do
      before { database.client.exec "INSERT INTO public.tbl_1 VALUES (1), (2);" }
      after { database.client.exec "TRUNCATE public.tbl_1;" }
      it { expect(database.tables[0].rows_count).to eq(2) }
    end
  end

end
