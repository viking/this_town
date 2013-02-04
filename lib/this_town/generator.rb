module ThisTown
  class Generator
    TEMPLATES_PATH = File.expand_path(File.join(File.dirname(__FILE__),
      "..", "..", "templates"))

    attr_reader :gem_name, :constant_name, :constant_array, :author, :email

    def initialize(args)
      #usage if args.empty?

      @destination_root = args.shift
      base_name = File.basename(@destination_root)
      @gem_name = base_name

      @constant_name = base_name.split('_').map { |p|
        p[0..0].upcase + p[1..-1]
      }.join
      if @constant_name =~ /-/
        @constant_name = @constant_name.split('-').map { |q|
          q[0..0].upcase + q[1..-1]
        }.join('::')
      end
      @constant_array = @constant_name.split('::')

      git_user_name = `git config user.name`.chomp
      git_user_email = `git config user.email`.chomp
      @author =
        if git_user_name.empty?
          "TODO: Write your name"
        else
          git_user_name
        end
      @email =
        if git_user_email.empty?
          "TODO: Write your email address"
        else
          git_user_email
        end
    end

    def run
      # root
      %w{Gemfile LICENSE.txt README.md Rakefile}.each do |template_path|
        template(template_path)
      end
      template "newgem.gemspec", "#{gem_name}.gemspec"
      file "gitignore", ".gitignore"

      # lib
      template "lib/newgem.rb", "lib/#{gem_name}.rb"
      template "lib/newgem/version.rb", "lib/#{gem_name}/version.rb"
    end

    private

    def template_binding
      binding
    end

    def template(template_path, destination_path = template_path)
      out_path = File.expand_path(destination_path, @destination_root)
      if File.exists?(out_path)
        raise "file already exists: #{out_path}"
      end
      FileUtils.mkdir_p(File.dirname(out_path))

      in_path = File.expand_path(template_path, TEMPLATES_PATH)
      erb = ERB.new(File.read(in_path), nil, "-")
      output = erb.result(template_binding)
      File.open(out_path, 'w') { |f| f.write(output) }
    end

    def file(template_path, destination_path = template_path)
      out_path = File.expand_path(destination_path, @destination_root)
      if File.exists?(out_path)
        raise "file already exists: #{out_path}"
      end
      in_path = File.expand_path(template_path, TEMPLATES_PATH)
      FileUtils.cp(in_path, out_path)
    end
  end
end
