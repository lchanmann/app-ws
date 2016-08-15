require 'rails_helper'

RSpec.describe PostgreSQL::Table, stub_api: true do
  let(:deployment) { Deployment.find $deployment_id }
  let(:database) { PostgreSQL::Database.new name: 'postgres', deployment: deployment }
  let(:table) { PostgreSQL::Table.new name: 'tbl_1', database: database, schema: 'public' }

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

    it "should support different schema" do
      expect(table.columns.size).to eq(1)
      table.schema = "app-ws_test"
      expect(table.columns.size).to eq(2)
    end

    context 'inexistence table' do
      let(:table) { PostgreSQL::Table.new name: "hello", schema: "public", database: database }
      it { expect{table.columns}.to raise_error(Errors::NotFound, "Table not found.") }
    end

    context 'malicious table name' do
      let(:table) { PostgreSQL::Table.new name: "foo' or 1=1; --", schema: "public", database: database }

      it "should prevent hijacking" do
        expect{table.columns}.to raise_error(Errors::NotFound, "Table not found.")
      end
    end

    context 'malicious schema name' do
      let(:table) { PostgreSQL::Table.new name: "tbl_1", schema: "foo'", database: database }

      it "should prevent hijacking" do
        expect{table.columns}.to raise_error(Errors::NotFound, "Table not found.")
      end
    end
  end

  it "should respond to schema" do
    expect(table.schema).to eq("public")
  end

  describe '#sanitized_{attribute}' do
    let(:table) { PostgreSQL::Table.new name: "bar'", schema: "foo'" }

    it { expect(table.sanitized_name).to eq("bar''") }
    it { expect(table.sanitized_schema).to eq("foo''") }
    it { expect{table.sanitized_what}.to raise_error(NoMethodError, "undefined attribute `what' for PostgreSQL::Table") }
    it { expect(table.sanitized_database).to be_nil }
  end

  it { expect{table.oops}.to raise_error(NoMethodError) }

  describe '#data' do
    before do
      database.client.exec(<<-eos
        INSERT INTO public.tbl_1 (column_1)
        VALUES
          (1), (2), (3), (4), (5);
        eos
        )
    end
    after { database.client.exec "TRUNCATE public.tbl_1;"  }
    it { expect(table.data.count).to eq(5) }
    it { expect(table.data[0]['column_1']).to eq(1.to_s) }
  end
end
