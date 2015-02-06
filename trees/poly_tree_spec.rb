require 'rspec'
require_relative 'poly_tree'

describe Node do
  describe "#initialize" do
	  let(:node) { Node.new(1) }

    it "should set an initial value" do
      expect(node.value).to eq(1)
    end

    it "should set parent to nil" do
      expect(node.parent).to be_nil
    end

    it "should set children to an empty array" do
      expect(node.children).to eq([])
    end
  end
end

#testing
# tree = PolyTree.new(1)
# node2 = tree.add_node(2)
# node3 = tree.add_node(3)

describe PolyTree do
	let(:tree) { PolyTree.new(1) }
	let(:node2) { tree.add_node(2) }
	let(:node3) { tree.add_node(3) }
	let(:node4) { tree.add_node(4, node2) }

	describe "#add_node" do 
		it "sets the parent to the root when no parent passed" do
			expect(node2.parent).to eq(tree.root)
		end

		it "sets the parent to be the passed node" do
			expect(node4.parent).to eq(node2)
		end

		it "adds the new node to the parent's children" do
			expect(tree.root.children).to include(node2)
			expect(tree.root.children).to include(node3)
			expect(node2.children).to include(node4)
		end
	end
end

