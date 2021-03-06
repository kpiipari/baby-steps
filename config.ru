require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end


use ParentController
use ChildController
use MilestoneController
use Rack::MethodOverride
run ApplicationController