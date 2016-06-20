lines = File.readlines(ARGV.first) 
line_count = lines.size 
text = lines.join
total_charchaters = text.size
total_charchaters_nospace = text.gsub(/\s+/, '').length
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length	
stopwords = %w{the a by on for of are with just but and to the my I has some in}
keywords = word_count.select { |word| !stopwords.include?(word) }
keywords_percentage = ((keywords.length.to_f / word_count.length.to_f) * 100).to_i

puts "#{line_count} lines and #{total_charchaters} charachaters"
puts "#{total_charchaters_nospace} charachaters excluding whitespace"
puts "#{word_count} words"
puts "#{sentence_count} sentences #{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)" 
puts "#{word_count / sentence_count} words per sentence (average)"
puts "keywords percentage #{keywords_percentage}"
