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

  describe '#print' do
    let(:accounts) { {123 => -2748} }
    let(:output_expected) {  }

    it { expect { print_balance(accounts) }.to output(/Saldo final de R\$ -27.48 na conta 123/).to_stdout }
  end

  describe '#process_transactions' do
    let(:accounts) { {123 => 13052, 531 => 89000, 2314 => 123400} }
    let(:csv_transactions_file) { 'spec/fixtures/transacoes.csv' }
    let(:expected) { {123 => -2748, 531 => 21400, 2314 => 18100 } }

    it{ expect(process_transactions(accounts, csv_transactions_file)).to eq expected }

    context 'account with negative balance' do
      let(:accounts) { {123 => -1000} }

      context 'debit' do
        let(:expected) { {123 => -2300} }

        it 'applies 300 fee' do
          expect(CSV).to receive(:read).
            with(csv_transactions_file, {:converters=>:numeric, :headers=>false}) {[[123,-1000]]}

          expect(process_transactions(accounts, csv_transactions_file)).to eq expected
        end
      end

      context 'credit' do
        let(:expected) { {123 => -100} }

        it 'applies 300 fee' do
          expect(CSV).to receive(:read).
            with(csv_transactions_file, {:converters=>:numeric, :headers=>false}) {[[123,900]]}

          expect(process_transactions(accounts, csv_transactions_file)).to eq expected
        end
      end
    end
  end
end
