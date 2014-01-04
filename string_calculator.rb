class StringCalculator
  REGEXP_SPLITTER = /[,\n]/

  def self.add(numbers)
    length = numbers.length

    return 0 if length == 0

    regexp_splitter = REGEXP_SPLITTER

    matches = numbers.match(%r{\/\/([^\n]+)\\n})
    if matches
      regexp_splitters = matches[1]
      regexp_splitter = regexp_splitters.scan(/\[([^\]]+)\]/).map(&:first)
      regexp_splitter = Regexp.new("(#{regexp_splitter.map { |v| Regexp.escape(v) }.join('|')})")
      numbers.gsub!(matches[0], '')
    end

    numbers = numbers.
      split(regexp_splitter).
      map(&:to_i)

    negatives = numbers.select { |v| v < 0 }

    raise "Error: #{negatives.join(',')}" unless negatives.empty?

    numbers.
      reject { |v| v > 1000 }.
      reduce(:+)
  end
end

#input_data.split(',').map(&:to_i).reduce(:+)
