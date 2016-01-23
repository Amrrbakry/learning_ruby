def caesar_cipher(text, shift_factor)
	lower_case_letters = ('a'..'z').to_a
	upper_case_letters = ('A'..'Z').to_a
	ciphered_text = []

	text.each_char do |letter| 
		if lower_case_letters.include? letter
			letter_index = lower_case_letters.index letter
			letter = lower_case_letters[(letter_index + shift_factor) % 26]
		elsif upper_case_letters.include? letter
			letter_index = upper_case_letters.index letter
			letter = upper_case_letters[(letter_index + shift_factor) % 26]
		end
		ciphered_text << letter
	end
	puts ciphered_text
end
			
