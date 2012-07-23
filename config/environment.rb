# Load the rails application
Date::DATE_FORMATS[:default] = "%d.%m.%Y"
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Gc::Application.initialize!
