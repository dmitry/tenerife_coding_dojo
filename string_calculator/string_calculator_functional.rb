class StringCalculatorFunctional
  def self.add(string)
    return 0 if empty?(string)
    return convert_and_sum(split_by_comma(string))
  end

  def self.empty?(string)
    string.empty?
  end

  def self.split_by_comma(string)
    string.split(retrieve_delimeter(string))
  end

  def self.convert_and_sum(strings)
    sum_when_positive(strings.map(&:to_i))
  end

  def self.sum_when_positive(numbers)
    check_for_negative_numbers(numbers)
    numbers.select { |v| v <= 1000 }.reduce(:+)
  end

  def self.check_for_negative_numbers(numbers)
    raise_negative_numbers_error(numbers.select { |v| v < 0 })
  end

  def self.raise_negative_numbers_error(numbers)
    unless numbers.empty?
      raise "Negative numbers: #{numbers.join(',')}"
    end
  end

  def self.retrieve_delimeter(string)
    process_matches(match_prefix_delimiter(string))
  end

  def self.match_prefix_delimiter(string)
    string.match(%r{//\[?([^\]\n]+)\]?\n})
  end

  def self.process_matches(matches)
    if matches
      matches[1]
    else
      /[;,\n]/
    end
  end
end