require 'rubygems'
require 'rspec'
require './string_calculator_functional.rb'

describe StringCalculator do

  describe 'add' do
    it 'takes empty string and returns 0' do
      expect(StringCalculator.add('')).to eq 0
    end

    it 'takes 1 and returns 1' do
      expect(StringCalculator.add('1')).to eq 1
    end

    it 'takes 1,2 and returns 3' do
      expect(StringCalculator.add('1,2')).to eq 3
    end

    it 'takes 10 numbers splitted by comma and returns sum of it' do
      strings = (0..10).to_a.join(',')
      expect(StringCalculator.add(strings)).to eq 55
    end

    it 'takes 3 numbers with comma and new line and returns the sum of them' do
      sum = StringCalculator.add("1\n2,3")

      expect(sum).to eq 6
    end

    it 'takes delimiter on the first line and then uses it to split and sum the numbers' do
      expect(StringCalculator.add("//;\n1;2")).to eq 3
      expect(StringCalculator.add("//:\n1;2")).to eq 3
    end

    it 'takes negative number and raise an exception' do
      expect { StringCalculator.add('-5') }.to raise_error
    end

    it 'takes multiple negative numbers and raise an exception with the negative numbers' do
      expect { StringCalculator.add('-5,5,-3,1,4') }.to raise_error('negative numbers: -5,-3')
    end

    it 'ignores numbers greater than 1000' do
      expect(StringCalculator.add('2,1000,1001')).to eq 1002
    end

    it 'delimeters can be any length with a given format' do
      numbers = '//[***]\n1***2***3'
      expect(StringCalculator.add(numbers)).to eq 6
    end

    it 'can be many delimeters' do
      numbers = '//[*][%]\n1*2%3'
      expect(StringCalculator.add(numbers)).to eq 6
    end
  end


end