module GolosCloud
  module Tx
    class DelegateVestingShare < GolosCloud::SqlBase

      self.table_name = :TxDelegateVestingShares

    end
  end
end

# Structure
#
# GolosCloud::Tx::DelegateVestingShare(
#   ID: integer,
#   tx_id: integer,
#   delegator: varchar,
#   delegatee: varchar,
#   vesting_shares: money,
#   timestamp: datetime
# )
