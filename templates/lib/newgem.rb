require "<%= gem_name %>/version"

<%- constant_array.each_with_index do |c, i| -%>
<%= '  ' * i %>module <%= c %>
<%- end -%>
<%= '  ' * constant_array.size %># Your code goes here...
<%- (constant_array.size - 1).downto(0) do |i| -%>
<%= '  ' * i %>end
<%- end -%>
