module GolosCloud
  module Vo
    class FillConvertRequest < GolosCloud::SqlBase

      self.table_name = :VOFillConvertRequest

    end
  end
end

# Structure
#
# GolosCloud::Vo::FillConvertRequest(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   owner: varchar,
#   requestid: integer,
#   amount_in: varchar,
#   amount_out: varchar
# )
