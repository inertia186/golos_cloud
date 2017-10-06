module GolosCloud
  module Tx
    class WithdrawVestingRoute < GolosCloud::SqlBase

      self.table_name = :TxWithdrawVestingRoutes

    end
  end
end

# Structure
#
# GolosCloud::Tx::WithdrawVestingRoute(
#   ID: integer,
#   tx_id: integer,
#   from_account: varchar,
#   to_account: varchar,
#   percent: integer,
#   auto_vest: boolean,
#   timestamp: datetime
# )
