class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    content = File.read(filename)
    content = content.downcase.gsub(/[^a-z ]/, ' ')
    STOP_WORDS.each do |x|
      content = content.gsub(' '+x+' ', ' ')
    end
    @words = content.split.sort

  end

  attr_accessor :words

  def frequency(word)
    counter = 0
    words.each do |x|
      if word == x
        counter = counter + 1
      end
    end
    counter
  end

  def frequencies
    freqArr = []
    words.each do |x|
      freqArr.push([x, frequency(x)])
    end
    freqArr.to_h
  end

  def top_words(number)
    arr = frequencies.sort_by {|key, value| key}
    arr = arr.sort_by {|key, value| value}
    finishedArr =[]
    counter = 0;
    arr.each do |key, value|
      if counter >= (arr.length-number)
        finishedArr.push([key, value])
      end
      counter = counter + 1
    end
    finishedArr.sort_by {|key, value| value}.reverse!
  end

  def print_report
    wordArr = top_words(frequencies.length)
    wordArr.each do |key, value|
      puts "#{key} | #{value} " + "*"*value
    end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
