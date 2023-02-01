require 'rails_helper'

RSpec.describe Dog, type: :model do
  it "should validate the presence of name" do
    dog = Dog.create age:5, enjoys:'Long walks on the beach', image:'https://thiscatdoesnotexist.com/'
    expect(dog.errors[:name]).to_not be_empty
  end
  it "should validate presence of age" do
    dog = Dog.create name:'Billy', enjoys:'Long walks on the beach', image:'https://thiscatdoesnotexist.com/'
      expect(dog.errors[:age]).to_not be_empty
  end
  it "should validate presence of enjoys" do
    dog = Dog.create name:'Billy', age: 5, image:'https://thiscatdoesnotexist.com/'
    expect(dog.errors[:enjoys]).to_not be_empty
  end
  it "should validate presence of an image" do
    dog = Dog.create 
    # name:'Billy', age: 5, enjoys:'Long walks on the beach'
    expect(dog.errors[:image]).to_not be_empty
  end
  it "should validate enjoys is longer than 10 characters" do
    dog = Dog.create name:'Billy', age: 5, enjoys:'food', image:'https://thiscatdoesnotexist.com/'
    expect(dog.errors[:enjoys].first).to eq("is too short (minimum is 10 characters)")
    expect(dog.errors[:enjoys]).to_not be_empty
  end
  it "should validate the presence of name" do
    editDog = Dog.update age:5, enjoys:'Long walks on the beach', image:'https://thiscatdoesnotexist.com/'
    expect(dog.errors[:name]).to_not be_empty
end

