module Dhl
  class DraftsResource < Resource
    def list
      Draft.new get_request("drafts")
    end

    def create(**attributes)
      Draft.new post_request("drafts", body: attributes)
    end

    def retrieve(id:)
      Draft.new get_request("drafts/#{id}")
    end

    def delete(id: nil, **attributes)
      if id.nil?
        delete_request("drafts/delete/#{id}")
      else
        post_request("drafts/delete", body: attributes)
      end
    end

    def import(**attributes)
      Draft.new post_request("drafts/import", body: attributes)
    end

    def promote(**attributes)
      Draft.new post_request("drafts/promote", body: attributes)
    end
  end
end