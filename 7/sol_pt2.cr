enum NodeTypes
    File
    Directory
end


class Node
  include Enumerable(Node)

  property children : Array(Node) = Array(Node).new
  property! parent : Node?
  property name : String

  def size
    if file?
      @size
    else
      children.reduce(0) { |acc, i| acc + i.size }
    end
  end

  def initialize(@name : String, @type : NodeTypes = NodeTypes::Directory,
      @size : Int = 0, @parent : Node? = nil)
  end

  def file?
    @type == NodeTypes::File ? true : false
  end

  def push(node : Node)
    node.parent = self
    children.push node
  end

  def to_s(io : IO)
    io << self.to_s
  end

  def to_s(depth : Int = 0, recursive : Bool = false) : String
    String.build do |str|
      str << " "*depth << "#{name} (#{@type}, size=#{size})"
      if recursive
        str << '\n' << children.join() { |x| x.to_s depth + 1, true }
      end
    end
  end

  def select(&block : Node -> Bool) : Array(Node)
    ary = Array(Node).new
    each { |e|
      ary << e if block.call e
    }
    ary
  end

  def each(recursive : Bool = true, &block : Node -> )
    children.each { |x|
      yield x
      if recursive
        x.each &block
      end
    }
  end

  def find(if_none = nil, &block : Node -> Bool)
    return children.find { |x| block.call x }
  end
end


TOTAL_SPACE = 70000000
MIN_REQUIRED_SPACE = 30000000

File.open("input.txt") do |file|
  # Create root node
  root = Node.new "/"
  current_dir = root

  file.each_line do |line|
    data = line.split
    # Check if it is a command
    if data[0] == "$"
      if data[1] == "cd"
        case data[2]
        when ".."
          current_dir = current_dir.parent
        when "/"
          current_dir = root
        else
          if found_dir = current_dir.find { |i| i.name == data[2]}
            current_dir = found_dir
          else
            raise Exception.new "#{data[2]} not found"
          end
        end
      end
    # Only possible alternative is listing
    else
      # data[1] is always filename
      if !current_dir.find() { |i| i.name == data[1]}
        if data[0] == "dir"
          new_node = Node.new data[1]
        else
          new_node = Node.new(data[1], NodeTypes::File, data[0].to_i)
        end
        current_dir.push new_node
      end
    end
  end

  total_used_space = root.size
  min_space_to_free = (TOTAL_SPACE - MIN_REQUIRED_SPACE - total_used_space).abs

  dirs = root.select { |x| !x.file? && x.size >= min_space_to_free }
  dirs.sort! { |x, y| x.size <=> y.size }
  puts dirs[0].size
end
