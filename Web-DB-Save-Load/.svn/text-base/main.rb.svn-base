require 'sinatra'
require 'fileutils'

enable :sessions

PATH_TO_RAILS_DB_DIR=File.join('', 'home', 'jc155857', 'Documents', 'SVN', 'cp2013-zoo-monitoring-software', 'Web-CP2013-Zoo', 'db')
#PATH_TO_RAILS_DB_DIR=File.join('', 'Users', 'robert', 'Documents', 'SVN', 'cp2013-zoo-monitoring-software', 'Web-CP2013-Zoo', 'db')
#PATH_TO_RAILS_DB_DIR=File.join('', 'home', 'robert', 'Documents', 'SVN', 'cp2013-zoo-monitoring-software', 'Web-CP2013-Zoo', 'db')

# Abstract class to represent a path action.
# A class that performs an action, given a path.
class PathActionClient
  def action path
  end
end

# Abstract class to represent a path actioner.
# A class which represents the resolution of a path, that can be updated.
class PathActioner

  def initialize path_action_client
    @path_action_client = path_action_client
  end

  def detect_path_update
    path = get_specified_path()
    @path_action_client.action(path)
  end

end

# Save path actioner, determines a save path, and calls on the associated
# Action Client
class SavePathActioner < PathActioner
  def initialize client, params
    super(client)
    save_file_name = "#{params[:save_file_name]}.sqlite3"
    @save_path = File.join(PATH_TO_RAILS_DB_DIR, save_file_name)
    detect_path_update()
  end

  def get_specified_path
    return @save_path
  end
end

# Load path actioner, determines a load path, and calls on the associated
# Action Client
class LoadPathActioner < PathActioner
  def initialize client, params
    super(client)
    load_file_name = params[:load_file_name]
    @load_path = File.join(PATH_TO_RAILS_DB_DIR, load_file_name)
    detect_path_update()
  end

  def get_specified_path
    return @load_path
  end
end

# Save action implementation
class SaveActionClient < PathActionClient
  def action path
    existing_db = File.join(PATH_TO_RAILS_DB_DIR, 'development.sqlite3')
    FileUtils.cp(existing_db, path)
  end
end

# Load action implementation
class LoadActionClient < PathActionClient
  def action path
    existing_db = File.join(PATH_TO_RAILS_DB_DIR, 'development.sqlite3')
    existing_db_backup = File.join(PATH_TO_RAILS_DB_DIR, "development.sqlite3.backup_#{Time.now.to_i}")

    FileUtils.cp(existing_db, existing_db_backup)
    FileUtils.cp(path, existing_db)
  end
end

###########
#
# Sinatra Code
#
###########


get '/' do
  erb :index, :layout => :layout
end

get '/save/?' do
  erb :save, :layout => :layout
end

get '/load/?' do
  @files_from_which_to_load = []
  Dir.foreach(PATH_TO_RAILS_DB_DIR) do |f|
    if f != 'development.sqlite3' and f =~ /.*\.sqlite3$/
      @files_from_which_to_load << f
    end
  end

  erb :load, :layout => :layout
end

post '/save/?' do
  save_action_client = SaveActionClient.new()
  save_path_actioner = SavePathActioner.new(save_action_client, params)

  session['notification'] = "#{save_path_actioner.get_specified_path()} has been saved"
  redirect "/"
end

post '/load/?' do
  load_action_client = LoadActionClient.new()
  load_path_actioner = LoadPathActioner.new(load_action_client, params)

  session['notification'] = "#{load_path_actioner.get_specified_path} has been loaded"
  redirect "/"
end
