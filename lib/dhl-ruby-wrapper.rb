require "faraday"
require "faraday_middleware"
require "dhl/version"

module Dhl
  autoload :Client, "dhl/client"
  autoload :Error, "dhl/error"
  autoload :Object, "dhl/object"
  autoload :Resource, "dhl/resource"

  autoload :AuthenticateResource, "dhl/resources/authenticate"
  autoload :DraftsResource, "dhl/resources/drafts"

  autoload :Token, "dhl/objects/token"
end
