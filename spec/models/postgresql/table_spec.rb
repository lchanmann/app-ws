require 'rails_helper'

RSpec.describe PostgreSQL::Table, stub_api: true do
  let(:deployment) { Deployment.find $deployment_id }
  let(:database) { PostgreSQL::Database.new name: 'postgres', deployment: deployment }
  let(:table) { PostgreSQL::Table.new name: 'tbl_1', database: database }

  describe '#columns' do
    describe 'data structure' do
      subject { table.columns[0] }
      it "should respond to name" do
        expect(subject.name).to eq("column_1")
      end

      it "should respond to dataype" do
        expect(subject.datatype).to eq("integer")
      end
    end

    context 'inexistence table' do
      let(:table) { PostgreSQL::Table.new name: "foo' or 1=1; --", database: database }
      it { expect{table.columns}.to raise_error(Errors::NotFound, "Table not found.") }
    end

    context 'malicious table name' do
      let(:table) { PostgreSQL::Table.new name: "foo' or 1=1; --", database: database }

      it "should prevent hijacking" do
        expect{table.columns}.to raise_error(Errors::NotFound, "Table not found.")
      end
    end
  end

end
