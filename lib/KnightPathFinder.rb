require_relative "./00_tree_node.rb"

class KnightPathFinder
   
    attr_reader :considered_positions, :root_node
    #pos: [x,y] #starting position
    def initialize(start_pos)
        @start_pos = start_pos
        #move tree
        #values in this tree are positions
        #the children of a node are positions a knight can move to from
        #the parent
        @root_node = PolyTreeNode.new(start_pos)   
        
        #considered_positions are all previously considered positions
        @considered_positions = [start_pos]
        
        #this method will build out the move tree from the root node
        #self.build_move_tree
    end

    #given a pos,
    #return an array of the up to 8 positions the knight can move to
    def valid_moves(pos)
        x,y = pos
        returnarray = []
        moves = [   [2,  1],[1,  2],
                    [2, -1],[1, -2],
                    [-2, 1],[-1, 2],
                    [-2,-1],[-1,-2]]

        moves.each do |move|
            xchange, ychange = move
            returnarray << [x+xchange, y+ychange]
        end

        return returnarray.select do |pos|
            x,y = pos
            x > 0 && x < 8 && y > 0 && y < 8
        end
    end

    #this is valid moves with all the previously considered positions filtered out
    def new_move_positions(pos)
        new_positions = valid_moves(pos).select do |pos| 
            !@considered_positions.include?(pos)
        end
        @considered_positions += new_positions
        return new_positions
    end

    def build_move_tree
        #knight = KnightPathFinder([4,4])
        #@root_node = PolyTreeNode([4,4])
        #goal: make @root_node's .children a tree of new moves to all positions
        #@root_node.add_child(PolyTreeNode([new_move]))

        queue = []
        queue.push(@root_node) #queue = [root_node(PTN)]
        
        while queue != []
            current_node = queue.shift
            #current_node = root_node

            #run new move pos at root_node.value
            new_move_positions(current_node.value).each do |pos|
                #for each new move pos,
                new_pos_node = PolyTreeNode.new(pos) #make a node out of it
                queue << new_pos_node #add the node to the queue
                current_node.add_child(new_pos_node) #add the node to be child of the current node from the queue
            end 
        end
    end 
end

kpf = KnightPathFinder.new([4,4])
kpf.build_move_tree
p kpf.root_node