module GolosCloud
  module Tx
    class Pow < GolosCloud::SqlBase

      self.table_name = :TxPows

    end
  end
end

# Structure
#
# GolosCloud::Tx::Pow(
#   ID: integer,
#   tx_id: integer,
#   worker_account: varchar,
#   block_id: varchar,
#   timestamp: datetime
# )
