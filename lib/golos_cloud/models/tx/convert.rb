module GolosCloud
  module Tx
    class Convert < GolosCloud::SqlBase

      self.table_name = :TxConverts

    end
  end
end

# Structure
#
# GolosCloud::Tx::Convert(
#   ID: integer,
#   tx_id: integer,
#   owner: varchar,
#   requestid: integer,
#   amount: money,
#   timestamp: datetime
# )
