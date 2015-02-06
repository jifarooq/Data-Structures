require 'rspec'
require_relative "linked_list"

describe LinkedList do
  it "pushes values into the list" do
    list = LinkedList.new
    (1..3).each { |val| list.push(val) }

    expect(list[0].value).to eq(1)
    expect(list[1].value).to eq(2)
    expect(list[2].value).to eq(3)
  end

  it "raises error on out of bounds access" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)

    expect do
      list[2]
    end.to raise_error("index out of range")
  end

  it "pops values from the list" do
    list = LinkedList.new
    (1..3).each { |val| list.push(val) }

    expect(list.pop).to eq(3)
    expect(list[0].value).to eq(1)
    expect(list[1].value).to eq(2)

    expect do
      list[2]
    end.to raise_error("index out of range")
  end

  it "unshifts values into the list" do
    list = LinkedList.new
    (1..3).each { |val| list.unshift(val) }

    expect(list[0].value).to eq(3)
    expect(list[1].value).to eq(2)
    expect(list[2].value).to eq(1)
  end

  it "shifts values out of the list" do
    list = LinkedList.new
    (1..3).each { |val| list.push(val) }

    expect(list.shift).to eq(1)
    expect(list[0].value).to eq(2)
    expect(list[1].value).to eq(3)
  end
end

# TODO: Test internals.
# TODO: Test what happens when you call remove on links. Especially
# when the list goes empty.
