class StringCalculatorSimple
  DEFAULT_REGEXP_SPLITTER = /[,\n]/
  DELIMITER_PREFIX_PATTERN = %r{//\[?([^\n]+)\]?\n}
  DELIMITER_PATTERN = /\[?([^\]]+)\]?/

  def self.add(numbers)
    length = numbers.length

    return 0 if length == 0

    regexp_splitter = DEFAULT_REGEXP_SPLITTER

    matches = numbers.match(DELIMITER_PREFIX_PATTERN)
    if matches
      regexp_splitters = matches[1]
      regexp_splitter = regexp_splitters.
          scan(DELIMITER_PATTERN).
          map(&:first)

      regex = regexp_splitter.map { |v| Regexp.escape(v) }.join('|')
      regexp_splitter = Regexp.new("(#{regex})")
      numbers.gsub!(matches[0], '')
    end

    numbers = numbers.
      split(regexp_splitter).
      map(&:to_i)

    negatives = numbers.select { |v| v < 0 }

    raise "Negative numbers: #{negatives.join(',')}" unless negatives.empty?

    numbers.
      reject { |v| v > 1000 }.
      reduce(:+)
  end
end