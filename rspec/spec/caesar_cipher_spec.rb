require './lib/caesar_cipher'

describe "#caesar_cipher" do
	it "ciphers a letter according to the shift factor" do
			expect(caesar_cipher("a", 5)).to eql("f")
	end
	
	it "ciphers a word according to the shift factor" do
		expect(caesar_cipher("ruby", 7)).to eql("ybif")
	end

	it "preserves spaces between words" do
		expect(caesar_cipher("testing with rsepc", 4)).to eql("xiwxmrk amxl vwitg")
	end

	it "preserves capitalization" do
		expect(caesar_cipher("This IS Rspec", 9)).to eql("Cqrb RB Abynl")
	end

	it "handles a shift factor of zero" do
		expect(caesar_cipher("ruby", 0)).to eql("ruby")
	end

	it "handles letter shifts beyond z" do 
		expect(caesar_cipher("xyz", 7)).to eql("efg")
	end

	it "doesn't cipher non-alphabet characters" do
		expect(caesar_cipher("rspec!", 5)).to eql("wxujh!")
	end

end