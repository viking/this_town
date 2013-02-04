module ThisTown
  class Template
    def initialize(path, options)
      @erb = ERB.new(File.read(path), nil, "-", "@output")
      @options = options
    end

    def result
      @erb.result(binding)
    end

    def code
      constant_array.each_with_index do |constant, i|
        @output << (('  ' * i) + "module #{constant}\n")
      end

      # Pull a switcheroo to get the content
      old_output = @output
      @output = ""
      yield
      content = @output
      @output = old_output

      # Indent each line of content
      indent_num = constant_array.size - 1
      content.each_line do |line|
        @output << (('  ' * indent_num) + line)
      end

      (constant_array.size - 1).downto(0) do |i|
        @output << (('  ' * i) + "end\n")
      end
    end

    def method_missing(name, *args, &block)
      if @options.has_key?(name)
        @options[name]
      else
        super
      end
    end
  end
end
