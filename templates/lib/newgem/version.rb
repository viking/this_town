<%- constant_array.each_with_index do |c, i| -%>
<%= '  ' * i %>module <%= c %>
<%- end -%>
<%= '  ' * constant_array.size %>VERSION = "0.0.1"
<%- (constant_array.size - 1).downto(0) do |i| -%>
<%= '  ' * i %>end
<%- end -%>
