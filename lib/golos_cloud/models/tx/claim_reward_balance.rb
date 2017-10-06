module GolosCloud
  module Tx
    class ClaimRewardBalance < GolosCloud::SqlBase

      self.table_name = :TxClaimRewardBalances

    end
  end
end

# Structure
#
# GolosCloud::Tx::ClaimRewardBalance(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   reward_steem: money,
#   reward_sbd: money,
#   reward_vests: money,
#   timestamp: datetime
# )
