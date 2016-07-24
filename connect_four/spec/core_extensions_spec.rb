require './lib/connect_four/core_extensions.rb'


describe Array do
  context "#all_empty?" do
  	it "returns true if all elements of the array are empty" do
  	  expect(["", "", ""].all_empty?).to be true
  	end

  	it "returns false if some of the elements of the array are not empty" do
  	  expect(["", 1, Object.new, :a].all_empty?).to be false
  	end

  	it "returns true for an empty array" do
  	  expect([].all_empty?).to be true
  	end
  end

  context "#all_same?" do
		it "returns true if all elements of the Array are the same" do
		  expect(["A", "A", "A"].all_same?).to be true
		end
		 
		it "returns false if some of the Array elements are not the same" do
		  expect(["", 1, "", Object.new, :a].all_same?).to be false
		end
		 
		it "returns true for an empty Array" do
		  expect([].all_same?).to be true
		end
  end

  context "#any_empty?" do
			it "returns true if any of the array elements is empty" do
			  expect(["A", "", "A"].any_empty?).to be true
			end
			 
			it "returns false if none of the array elements is empty" do
			  expect(["A", 1, "A", Object.new, :a].any_empty?).to be false
			end
			 
			it "returns true for an empty Array" do
			  expect([].any_empty?).to be true
			end
	  end

	  context "#none_empty?" do
		it "returns true if all elements of the Array are the same" do
		  expect(["A", "A", "A"].none_empty?).to be true
		end
		 
		it "returns false if some of the Array elements are not the same" do
		  expect(["", 1, "", Object.new, :a].none_empty?).to be false
		end
		 
		it "returns true for an empty Array" do
		  expect([].none_empty?).to be false
		end
  end
end
