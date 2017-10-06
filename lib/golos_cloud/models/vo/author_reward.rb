module GolosCloud
  module Vo
    class AuthorReward < GolosCloud::SqlBase

      self.table_name = :VOAuthorRewards

    end
  end
end

# Structure
#
# GolosCloud::Vo::AuthorReward(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   author: varchar,
#   permlink: varchar,
#   sdb_payout: money,
#   steem_payout: money,
#   vesting_payout: money
# )
