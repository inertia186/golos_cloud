module GolosCloud
  module Vo
    class CurationReward < GolosCloud::SqlBase

      self.table_name = :VOCurationRewards

    end
  end
end

# Structure
#
# GolosCloud::Vo::CurationReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   curator: varchar,
#   author: varchar,
#   permlink: varchar,
#   reward: varchar
# )
