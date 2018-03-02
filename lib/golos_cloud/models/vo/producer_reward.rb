module GolosCloud
  module Vo
    class ProducerReward < GolosCloud::SqlBase

      self.table_name = :VOProducerRewards

    end
  end
end

# Structure
#
# GolosCloud::Vo::ProducerReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   producer: varchar,
#   vesting_shares: money
# )
