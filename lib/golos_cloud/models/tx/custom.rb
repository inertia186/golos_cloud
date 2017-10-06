module GolosCloud
  module Tx
    class Custom < GolosCloud::SqlBase

      self.table_name = :TxCustoms

    end
  end
end

# Structure
#
# GolosCloud::Tx::Custom(
#   ID: integer,
#   tx_id: integer,
#   tid: varchar,
#   json_metadata: varchar_max,
#   timestamp: datetime
# )
