# frozen_string_literal: true
require_relative '../lib/bnm_rates'

RSpec.describe BnmRates do
  let(:test_rates) { BnmRates.new(date: '31.07.2021') }
  
  it 'has a version number' do
    expect(BnmRates::VERSION).not_to be nil
  end

  context 'with certain date' do
    subject { BnmRates.new(date: '12.12.2012') }

    it 'should return request date' do
      expect(subject.date).to eq '12.12.2012'
    end
  end

  context 'with default date' do
    subject { BnmRates.new }

    it 'should return actual date' do
      expect(subject.date).to eq Time.now.strftime("%d.%m.%Y")
    end
  end

  context 'attr response' do
    it 'should return hash of hashes' do
      expect(test_rates.response).to be_an Hash
    end
  end

  context '#char_codes' do
    it 'return valute char_codes array' do
      expect(test_rates.char_codes.size).to eq 43
    end
  end

  context '#exchange' do
    it 'should converse another currency to moldovan leu' do
      ron = Money.new('5_00', 'RON')

      result = test_rates.exchange(ron, :MDL)

      expect(result).to eq Money.new('21_62', 'MDL')
    end

    it 'should converse one currency to another currency' do
      hkd = Money.new('20_00', 'HKD')

      result = test_rates.exchange(hkd, :USD)

      expect(result).to eq Money.new('2_57', 'USD')
    end
  end
end
