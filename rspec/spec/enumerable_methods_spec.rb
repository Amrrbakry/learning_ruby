require './lib/enumerable_methods'

describe "enumberable" do

	subject { [1,2,3,4,5,6,7] }

	describe "#my_select" do
		it "selects numbers greater than 5" do
			expect(subject.my_select { |num| num > 5 }).to eql([6,7])
		end

		it "selects odd numbers" do
			expect(subject.my_select { |num| num.odd? }).to eql([1,3,5,7])
		end

		it "returns empty result when block is always false" do
			expect(subject.my_select { |num| num > 7 }).to be_empty 
		end
	end

	describe "#my_all?" do
		it "returns true when the block is always true" do
			expect(subject.my_all? { |num| num < 8 }).to be true
		end

		it "returns false when the block is sometimes false" do
			expect(subject.my_all? { |num| num.even? }).to be false
		end
	end

	describe "my_any?" do
		it "returns true when the block is sometimes right" do
			expect(subject.my_any? { |num| num.even? }).to be true
		end

		it "returns true when the block is always true" do
			expect(subject.my_any? { |num| num < 8 }).to be true
		end

		it "returns false when the block is always false" do
			expect(subject.my_any? { |num| num > 7 }).to be false
		end
	end

	describe "#my_none?" do
		it "returns true when the block is always false" do
			expect(subject.my_none? { |num| num > 7 }).to be true
		end

		it "returns false when the block is sometimes right" do
			expect(subject.my_none? { |num| num.even? }).to be false
		end
	end

	describe "#my_count" do
		
		subject { [1,2,3,4,5,6,7,7] }
		
		context "when no argument is supplied" do
			it "returns the number of elemnts in an array" do
				expect(subject.my_count).to eql(8)
			end
		end

		context "when given an empty array" do
			it "returns zero" do
				expect([].my_count).to eql(0)
			end
		end

		context "when an argument is supplied" do
			it "returns the number of elements that are equal to the supplied argument" do
				expect(subject.my_count(7)).to eql(2)
			end
		end
	end

	describe "#my_map" do 
		context "when a block is given" do
			it "returns mapped array" do
				expect(subject.my_map { |num| num += 1 }).to eql([2,3,4,5,6,7,8])
			end

			it "retains original array without change" do
				original = [1,2,3,4,5,6,7]
				subject.my_map { |num| num += 4 }
				expect(subject).to eql(original)
			end
		end

		context "when a proc is given" do 
			it "returns mapped array" do
				proc = Proc.new { |num| num += 1 }
				expect(subject.my_map(&proc)).to eql([2,3,4,5,6,7,8])
			end
		end
	end
end