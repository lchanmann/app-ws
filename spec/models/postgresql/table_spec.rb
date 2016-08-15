require 'rails_helper'

RSpec.describe PostgreSQL::Table do
  let(:client) { double("client") }
  let(:table) { PostgreSQL::Table.new name: 'tbl_1' }

  before { allow(table).to receive(:client).and_return(client) }

  describe '#columns' do
    subject { table.columns }
    it "should execute query to client" do
      expect(client).to receive(:exec).with(/WHERE table_name = 'tbl_1'/).and_return([{}])
      subject
    end

    describe 'data structure' do
      before { expect(client).to receive(:exec).and_return([{'column_name' => "column_1", 'data_type' => "integer"}]) }
      subject { table.columns[0] }
      it "should respond to name" do
        expect(subject.name).to eq("column_1")
      end

      it "should respond to dataype" do
        expect(subject.datatype).to eq("integer")
      end
    end

    context 'malicious table name' do
      let(:table) { PostgreSQL::Table.new name: "foo' or 1=1; --" }

      it "should sanitize table name" do
        expect(client).to receive(:exec).with(/WHERE table_name = 'foo'' or 1=1; --'/).and_return([{}])
        subject
      end
    end
  end

end
