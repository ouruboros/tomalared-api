# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# initialize constants
TYPES = {:post => {:type => "textarea"}, :quote => {:type => "text"}, :link => {:type => "text"}, :video => {:type => "text"}, :image => {:type => "text"} }

# figure out what type of post types we have by looking in the types directory for partials
# for each partial, check the first line for fields: 
# if it exists, arrayize the arguments and add the array to TYPES[:type]

TYPES.freeze

#Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self)
