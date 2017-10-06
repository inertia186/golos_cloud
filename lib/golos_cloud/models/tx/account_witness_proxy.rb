module GolosCloud
  module Tx
    class AccountWitnessProxy < GolosCloud::SqlBase

      self.table_name = :TxAccountWitnessProxies

    end
  end
end

# Structure
#
# GolosCloud::Tx::AccountWitnessProxy(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   Proxy: varchar,
#   timestamp: datetime
# )
