<%- code do -%>
  class Application < Sinatra::Base
    register Mustache::Sinatra

    set :root, Root.to_s
    set :mustache, {
      :templates => (Root + 'templates').to_s,
      :views => (Root + 'lib' + '<%= gem_name %>' + 'views').to_s,
      :namespace => <%= constant_name %>
    }
    enable :reload_templates if development?

    get "/" do
      "sup?"
    end
  end
<%- end -%>
