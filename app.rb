require('sinatra')
  require('sinatra/reloader')
  require('./lib/task')
  require('./lib/list')
  also_reload('lib/**/*.rb')
  require("pg")

DB=PG.connect({:dbname => "to_do_test"}) #change back to to_do after integration testing

get('/') do
  erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  erb(:list_success)
end
