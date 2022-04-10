require "csv"

class GolfUser < ApplicationRecord
  class << self
    def import(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        row["is_sent"] = (row["is_sent"] == "済") ? true : false
        params = row.to_hash.slice(*updatable_attributes)
        create(params)
      rescue => e
        Rails.logger.error(e)
      end
    end

    def updatable_attributes
      ["name", "email", "hash", "is_sent"]
    end
  end
end
