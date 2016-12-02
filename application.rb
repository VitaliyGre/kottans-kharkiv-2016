require_relative 'message'

class Application
  def call(env)
    path = env['PATH_INFO'].split('/')
    route = path[1] || :index
    send(route, env)
  end

  def index(env)
    str = get_full_layout('views/index.erb')

    [200, {'Content-Type' => 'text/html'}, [str]]
  end

  def link(env)
    param = Rack::Request.new(env).body.read
    text = param[(param.index('=') + 1)..-1]
    mes = Message.create(text)

    str = get_full_layout('views/link.erb')
    str.gsub!('<%=message%>', mes['safe_link'])

    [200, {'Content-Type' => 'text/html'}, [str]]
  end

  def message(env)
    link = env['PATH_INFO'].split('/')[2]
    mes = Message.find_by_link(link)
    result = "<h4>Sorry but we can't find your message</h4>"
    if mes
      result = "<h3>Your message:</h3><h4>#{mes['text']}</h4>"
      Message.delete_by_link(link)
    end

    str = get_full_layout('views/message.erb')
    str.sub!('<%=result%>', result)

    [200, {'Content-Type' => 'text/html'}, [str]]
  end

  private
  def get_full_layout(view)
    template = File.read('views/layout.erb')
    part = File.read(view)
    template.sub('<%=yield%>', part)
  end

end