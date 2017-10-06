module GolosCloud
  module Tx
    class AccountRecover < GolosCloud::SqlBase

      self.table_name = :TxAccountRecovers

    end
  end
end

# Structure
#
# GolosCloud::Tx::AccountRecover(
#   ID: integer,
#   tx_id: integer,
#   recovery_account: varchar,
#   account_to_recover: varchar,
#   recovered: boolean,
#   timestamp: datetime
# )
