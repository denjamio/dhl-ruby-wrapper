module Dhl
  class DraftsResource < Resource
    def list
      get_request("drafts")
    end
  end
end