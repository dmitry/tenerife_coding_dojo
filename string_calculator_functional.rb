class StringCalculator
  def self.add myString
    return 0 if empty?(myString)
    return convertAndSum(split_by_comma(myString))
  end

  def self.empty?(myString)
    myString.empty?
  end

  def self.split_by_comma(string)
    string.split(retrieve_delimeter(string))
  end

  def self.convertAndSum(strings)
    sum_when_positive(strings.map(&:to_i))
  end

  def self.sum_when_positive(numbers)
    check_for_negative_numbers(numbers)
    numbers.select {|v| v <= 1000}.reduce(:+)
  end

  def self.check_for_negative_numbers(numbers)
    raise_negative_numbers_error(numbers.select { |v| v < 0 })
  end

  def self.raise_negative_numbers_error(numbers)
    unless numbers.empty?
      raise "negative numbers: #{numbers.join(',')}"
    end
  end

  def self.retrieve_delimeter(string)
    processMatches( string.match(%r{//\[?([^\]\n]+)\]?\\n}) )
  end

  def self.processMatches matches
    if matches
      matches[1]
    else
      /[;,\n]/
    end
  end
end