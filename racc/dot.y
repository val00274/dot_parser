# dot.y
# 
# DOT Language file (Graphviz's source file) Parser, for Racc.
# 
# author: asatou <asatou@val.co.jp>
#

class DotParser::Parser

rule
  graph : strict_opt graph_or_digraph id_opt '{' graph_declare '}' { result = Graph.new(val[2], ! val[0].nil?, val[1].to_sym, val[4]) }

  strict_opt : 'strict'
             | /* none */

  graph_or_digraph : 'graph'
                   | 'digraph'

  id_opt : ID
         | /* none */
 
  graph_declare : stmt_list { result = val[0].flatten }

  stmt_list : stmt               { result = [ val[0] ] }
            | stmt ';'           { result = [ val[0] ] }
            | stmt ';' stmt_list { result = [ val[0], val[2] ] }

  stmt : node_stmt
       | edge_stmt
       | attr_stmt
       | ID '=' ID
       | subgraph

  attr_stmt : graph_or_node_or_edge attr_list { result = AttrList.new(val[0].to_sym, val[1].flatten) }
  
  graph_or_node_or_edge : 'graph'
                        | 'node'
                        | 'edge'

  attr_list : '[' a_list ']'           { result = val[1] }
            | '[' a_list ']' attr_list { result = [ val[1], val[4] ] }
  
  a_list : a            { result = [ val[0] ] }
         | a ',' a_list { result = [ val[0], val[2] ] }

  a : ID        { result = Attr.new(val[0], nil) }
    | ID '=' ID { result = Attr.new(val[0], val[2]) }

  edge_stmt : edge_declare attr_list_opt { result = Edge.new(val[0].flatten, val[1]) }

  edge_declare : node_id_or_subgraph edge_rhs { result = [ val[0], val[1] ] }

  node_id_or_subgraph : node_id
                      | subgraph

  edge_rhs : edgeop node_id_or_subgraph          { result = [ val[0], val[1] ] }
           | edgeop node_id_or_subgraph edge_rhs { result = [ val[0], val[1], val[2] ] }

  attr_list_opt : attr_list
                | /* none */

  node_stmt : node_id attr_list_opt { val[0].attr = val[1]; result = val[0] }

  node_id : ID port_opt { result = Node.new(val[0], val[1], nil) }
  
  port_opt : ':' ID                { result = [ val[1] ] }
           | ':' compass_pt        { result = [ val[1] ] }
           | ':' ID ':' compass_pt { result = [ val[1], val[3] ] }
           | /* none */            { result = [] }

  subgraph : 'subgraph' ID '{' stmt_list '}' { result = Graph.new(val[1], nil, :subgraph, val[3]) }
           | 'subgraph' '{' stmt_list '}'    { result = Graph.new(nil,    nil, :subgraph, val[2]) }
           | '{' stmt_list '}'               { result = Graph.new(nil,    nil, :subgraph, val[1]) }
  
  edgeop : '--' | '->'

  compass_pt : n | ne | e | se | s | sw | w | nw | c | _

end

---- header
Graph = Struct.new(:id, :strict?, :type, :statements)
AttrList = Struct.new(:type, :attrs)
Attr = Struct.new(:key, :value)
Edge = Struct.new(:path, :attrs)
Node = Struct.new(:id, :ports, :attrs)

---- inner
  def read(file)
      parse(file.readlines.join("").gsub("\n", ""))
  end

  def parse(str)
    @yydebug = true
    @q = []
    until str.nil? or str.empty?
      case str 
      when /^\s+/
      when /^(strict|graph|node)/
        @q.push [$&, $&]
      when /^\"([^"]+)\"/
        @q.push [:ID, $1]
      when /^[0-9a-zA-Z_]+/, /^-[0-9]+(\.[0-9]+)?/
        @q.push [:ID, $&]
      when /^(--|->)/, /^\W/
        @q.push [$&, $&]
      end
      str = $'
    end
    do_parse
  end
  
  def next_token
    @q.shift
  end

