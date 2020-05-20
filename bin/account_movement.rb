#!/usr/bin/env ruby

require 'csv'

def process(csv_accounts_file, csv_transactions_file)
  accounts_with_balance = process_acounts_file(csv_accounts_file)
  process_transactions(accounts_with_balance, csv_transactions_file)
  print_balance(accounts_with_balance)
end

def process_acounts_file(data_file)
  rows =  read_csv_file(data_file)
  rows.to_h { |k, v| [k, v.to_i] }
end

def process_transactions(balance_accounts, data_file)
  transactions = read_csv_file(data_file)

  transactions.each do |account, value|
    balance_accounts[account] = calculate_transaction(balance_accounts[account], value)
  end

  balance_accounts
end

def calculate_transaction(balance, value)
  balance += value
  balance -= 300 if (balance < 0 && value < 0)
  balance
end

def print_balance(accounts)
  accounts.each do |account, balance|
    p "Saldo final de R$ #{ balance.to_f / 100 } na conta #{account}"
  end
end

def read_csv_file(data_file)
  begin
    CSV.read(data_file, headers: false, converters: :numeric).reject(&:empty?)
  rescue => ex
    raise "Error reading #{data_file}: #{ex}"
  end
end

if $0 == __FILE__
  raise ArgumentError, "Usage: #{$0} must receive accounts file and transactions file " unless ARGV.length == 2
  process(ARGV[0], ARGV[1])
end
