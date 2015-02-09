module Printable
  # code taken from http://rubyquiz.com/quiz40.html
  # written by Brian Schröder

  def to_s(  )
      # We have log_2(n) levels
      #
      # Level i includes at most 2**i nodes when indexed starting from zero
      # That means last level needs the space for at most (2**(ceil(log_2(n)))) 
      #
      # Basic implementation: Reserve the space and fill it

      # Some constants for the ascii art
      short_arm_left = '/'
      short_arm_right = '\ '

      arm_left_start = "'"
      arm_left_end = "."

      arm_right_start = "`"
      arm_right_end = "."

      arm_line = '-'

      join_string = ' '

      # Constants for position calculation
      levels = Math.log(@store.size, 2).ceil

      max_node_width = @store[1..-1].map{ | node | node.to_s.length }.max
      max_line_width = 2 ** (levels-1) * max_node_width +
  (2 ** (levels-1)-1) * join_string.length

      (0...levels).inject([]) { | result, level |
        level_node_width = max_line_width / 2**level

        # Draw the arms leading to the nodes on this level
        if level > 0
          result <<
          Array.new(2**level) { | j |
            if @store[2**level+j]          # Only draw an arm, if there is a node
              if level_node_width < 5 # Draw short arm for short distances
                (j.even? ? short_arm_left :
  short_arm_right).center(level_node_width)
              else                    # Draw long arm for long distances
                if j.even?
                  (arm_left_end    + arm_line * (level_node_width / 2 -
  1) + arm_left_start).rjust(level_node_width)
                else
                  (arm_right_start + arm_line * (level_node_width / 2 -
  1) + arm_right_end ).ljust(level_node_width)
                end
              end
            else
              ' ' * level_node_width
            end
          }.join(join_string)#.center(max_line_width)
        end

        # Draw the node on this level
        result << @store[2**level...2**(level+1)].map { | node |
  node.to_s.center(level_node_width)
  }.join(join_string)#.center(max_line_width)
      }.join("\n")
  end

end