module GolosCloud
  module Tx
    class AccountUpdate < GolosCloud::SqlBase

      self.table_name = :TxAccountUpdates

    end
  end
end

# Structure
#
# GolosCloud::Tx::AccountUpdate(
#   ID: integer,
#   tx_id: integer,
#   account: varchar,
#   key_auth1: varchar,
#   key_auth2: varchar,
#   memo_key: varchar_max,
#   json_metadata: varchar_max,
#   timestamp: datetime
# )
