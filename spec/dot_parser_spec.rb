require 'rspec'
require 'dot_parser'

describe DotParser do
  it "DotParser.read" do
    graph = DotParser.read("spec/graph.dot")

    graph.type.should == :graph
    graph.statements.size.should == 8

    first_edge, *, last_edge = graph.statements
    first_edge.path.first.id.should == "a"
    first_edge.path.first.ports.should == ["n"]
    first_edge.path.last.id.should == "b"
    first_edge.path.last.ports.should == []

    last_edge.path.first.id.should == "e"
    last_edge.path.first.ports.should == []
    last_edge.path.last.id.should == "f"
    last_edge.path.first.ports.should == []
    last_edge.attrs.first.key.should == "len"
    last_edge.attrs.first.value.should == "4"
  end
end

