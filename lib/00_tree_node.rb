class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    # def inspect
    #     if @children.length == 0
    #         return "<PolyTreeNode @value=#{value}, @children=[]"
    #     else
    #         returnval = "<PolyTreeNode @value=#{value}, @children="
    #         @children.each do |child|
    #             return returnval += "#{child.inspect}"
    #         end
    #     end
    # end

    def parent=(parentnode)

        # leftside.parent=(newparent)
        # leftside is any node
        # leftside currently has a parent
        # 
        oldparent = @parent
        if oldparent != nil
            oldparent.children.delete(self)
        end

        @parent = parentnode
        #node.children should include self
        # 
        # node1's children should include node2
        # nodeq.parent=(node2)
        # this sets node2 to the parent of node1
        # we then have to set node1 to be the child of node2
        #parentnode.children << self
        if parentnode != nil
            parentnode.children << self
            parentnode.children.uniq!
        end
    end

    def add_child(new_child)
        new_child.parent = self
    end

    def remove_child(child_to_remove)
        if @children.include?(child_to_remove)
            child_to_remove.parent = nil
        else
            raise 'not a child'
        end
    end

    def dfs(target_value)
        #node.dfs(target_value)
        # if @value != self && children == []
        #     return nil
        # if @value != self && children.length == 0
        #     return nil
        # end
        
        if self.value == target_value
            return self
        else
            @children.each do |child|
                search = child.dfs(target_value)
                return search unless search
            end
        end
        nil
    end

    def bfs(target_value)

        queue = []
        queue.push(self)

        while queue != []
            current_node = queue.shift
            if current_node.value == target_value
                return current_node
            else
                current_node.children.each { |child| queue << child }
            end
        end
        nil
            
    end
end

