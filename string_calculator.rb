class StringCalculator
  def self.add(numbers)
    length = numbers.length

    return 0 if length == 0



    numbers = numbers.
      split(/[;,\n]/).
      map(&:to_i)

    negatives = numbers.select { |v| v < 0 }

    raise "Error: #{negatives.join(',')}" unless negatives.empty?

    numbers.
      reject { |v| v > 1000 }.
      reduce(:+)
  end
end

#input_data.split(',').map(&:to_i).reduce(:+)
