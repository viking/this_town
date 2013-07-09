module ThisTown
  class Generator
    TEMPLATES_PATH = File.expand_path(File.join(File.dirname(__FILE__),
      "..", "..", "templates"))

    def initialize(destination_root, options = {})
      @destination_root = destination_root
      @force = options[:force]

      base_name = File.basename(@destination_root)
      @gem_name = base_name
      constant_name = base_name.split('_').map { |p|
        p[0..0].upcase + p[1..-1]
      }.join
      if constant_name =~ /-/
        constant_name = constant_name.split('-').map { |q|
          q[0..0].upcase + q[1..-1]
        }.join('::')
      end
      constant_array = constant_name.split('::')

      git_user_name = `git config user.name`.chomp
      git_user_email = `git config user.email`.chomp
      author =
        if git_user_name.empty?
          "TODO: Write your name"
        else
          git_user_name
        end
      email =
        if git_user_email.empty?
          "TODO: Write your email address"
        else
          git_user_email
        end

      @template_options = {
        :gem_name => @gem_name, :constant_name => constant_name,
        :constant_array => constant_array, :author => author,
        :email => email
      }
    end

    def run
      directory "db/migrate"
      directory "views"

      # root
      root_templates = %w{Gemfile LICENSE.txt README.md Rakefile config.ru}
      root_templates.each do |template_path|
        template(template_path)
      end
      template "newgem.gemspec", "#{@gem_name}.gemspec"
      file "Guardfile"
      file "gitignore", ".gitignore"

      # lib
      template "lib/newgem.rb", "lib/#{@gem_name}.rb"
      template "lib/newgem/version.rb", "lib/#{@gem_name}/version.rb"
      template "lib/newgem/application.rb", "lib/#{@gem_name}/application.rb"

      # views
      template "views/layout.erb"
      file "views/index.erb"

      # config
      template "config/database.yml"

      # test
      template "test/helper.rb"
      template "test/unit/test_application.rb"

      # public
      file "public/reset.css"
      file "public/style.css"
      fetch "http://code.jquery.com/jquery-latest.min.js", "public/jquery.min.js"

      Dir.chdir(@destination_root) do
        `git init && git add .`
      end
    end

    private

    def template(template_path, destination_path = template_path)
      out_path = prepare_destination(destination_path)
      in_path = full_template_path("#{template_path}.erb")

      template = Template.new(in_path, @template_options)
      output = template.result
      File.open(out_path, 'w') { |f| f.write(output) }
    end

    def file(template_path, destination_path = template_path)
      out_path = prepare_destination(destination_path)
      in_path = full_template_path(template_path)

      FileUtils.cp(in_path, out_path)
    end

    def fetch(url, destination_path)
      out_path = prepare_destination(destination_path)
      open(url) do |u|
        File.open(out_path, 'w') do |f|
          f.write(u.read)
        end
      end
    end

    def full_template_path(template_path)
      File.expand_path(template_path, TEMPLATES_PATH)
    end

    def prepare_destination(destination_path)
      out_path = File.expand_path(destination_path, @destination_root)
      if !@force && File.exists?(out_path)
        raise "file already exists: #{out_path}"
      end
      directory(File.dirname(out_path))
      out_path
    end

    def directory(path)
      FileUtils.mkdir_p(File.expand_path(path, @destination_root))
    end
  end
end
