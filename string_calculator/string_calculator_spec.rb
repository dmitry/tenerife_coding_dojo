require 'rspec'

require './string_calculator_simple.rb'
require './string_calculator_functional.rb'


[StringCalculatorFunctional, StringCalculatorSimple].each do |klass|
  describe klass do

    describe 'add' do
      it 'takes empty string and returns 0' do
        expect(klass.add('')).to eq 0
      end

      it 'takes 1 and returns 1' do
        expect(klass.add('1')).to eq 1
      end

      it 'takes 1,2 and returns 3' do
        expect(klass.add('1,2')).to eq 3
      end

      it 'takes 10 numbers splitted by comma and returns sum of it' do
        strings = (0..10).to_a.join(',')
        expect(klass.add(strings)).to eq 55
      end

      it 'takes 3 numbers with comma and new line and returns the sum of them' do
        sum = klass.add("1\n2,3")

        expect(sum).to eq 6
      end

      it 'takes delimiter on the first line and then uses it to split and sum the numbers' do
        expect(klass.add("//;\n1;2")).to eq 3
        expect(klass.add("//:\n1:2")).to eq 3
      end

      it 'takes negative number and raise an exception' do
        expect { klass.add('-5') }.to raise_error
      end

      it 'takes multiple negative numbers and raise an exception with the negative numbers' do
        expect { klass.add('-5,5,-3,1,4') }.to raise_error('Negative numbers: -5,-3')
      end

      it 'ignores numbers greater than 1000' do
        expect(klass.add('2,1000,1001')).to eq 1002
      end

      it 'delimeters can be any length with a given format' do
        numbers = "//[***]\n1***2***3"
        expect(klass.add(numbers)).to eq 6
      end

      it 'can be many delimeters' do
        numbers = "//[*][%]\n1*2%3"
        expect(klass.add(numbers)).to eq 6
      end
    end
  end
end

# test additional methods in functional calculator
describe StringCalculatorFunctional do
  it 'creates regexp with multiple delimiters' do
    expect(StringCalculatorFunctional.regexp_with_multiple_delimiters(%w(, ***))).to eq /,|\*\*\*/
  end
end