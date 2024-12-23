module Rescuers
  module ActiveRecordRescue
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |error|
        error!({ error: "Not Found", message: error }, 404)
      end
    end
  end
end
