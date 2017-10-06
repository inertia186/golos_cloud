module GolosCloud
  module Vo
    class Interest < GolosCloud::SqlBase

      self.table_name = :VOInterests

    end
  end
end

# Structure
#
# GolosCloud::Vo::Interest(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   owner: varchar,
#   Interest: money
# )