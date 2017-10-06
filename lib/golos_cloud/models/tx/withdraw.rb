module GolosCloud
  module Tx
    class Withdraw < GolosCloud::SqlBase

      self.table_name = :TxWithdraws

    end
  end
end

# Structure
#
# GolosCloud::Tx::Withdraw(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   vesting_shares: money,
#   timestamp: datetime
# )
