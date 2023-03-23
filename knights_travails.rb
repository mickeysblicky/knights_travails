class MoveNode
    attr_reader :source, :parent

    MOVES = [[1, 2], [-2, -1], [-1, 2], [2, -1],
             [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze


    @@history = []

    def initialize(source, parent)
        @source = source
        @parent = parent
        @@history.push(source)
    end

    def children
        MOVES.map {|m| [@source[0] + m[0], @source[1] + m[1]]}
             .keep_if {|e| MoveNode.in_board?(e)}
             .reject {|e| @@history.include?(e)}
             .map {|e| MoveNode.new(e, self)}
    end

    def self.in_board?(arr)
        arr[0].between?(0, 7) && arr[1].between?(0, 7)
    end
end

def display_parent(node)
            display_parent(node.parent) unless node.parent.nil?
            p node.source
end

def move(src, dest)
    queue = []
    current_node = MoveNode.new(src, nil)
    until current_node.source == dest
        current_node.children.each {|child| queue << child}
        current_node = queue.shift
    end
    display_parent(current_node)
end

move([1,7], [7,1])