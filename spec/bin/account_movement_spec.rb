require 'spec_helper'
require_relative '../../bin/account_movement'

RSpec.describe 'account_movement' do
  describe '#read_csv_file' do
    let(:csv_account_file) { 'spec/fixtures/contas.csv' }
    let(:expected) { [[123,13052], [531,89000], [2314,123400]] }
    it{ expect(read_csv_file(csv_account_file)).to eq expected }

    context 'invalid file'do
      let(:csv_invalid_file) { 'spec/fixtures/invalid.csv' }

      it { expect{ read_csv_file(csv_invalid_file) }.to raise_error(RuntimeError, /Error reading/) }
    end
  end

  describe '#process_acounts_file' do
    let(:csv_account_file) { 'spec/fixtures/contas.csv' }
    let(:expected) { {123 => 13052, 531 => 89000, 2314 => 123400} }
    it{ expect(process_acounts_file(csv_account_file)).to eq expected }
  end
end
