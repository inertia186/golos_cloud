module GolosCloud
  module Tx
    class DeleteComment < GolosCloud::SqlBase

      self.table_name = :TxDeleteComments

    end
  end
end

# Structure
#
# GolosCloud::Tx::DeleteComment(
#   ID: integer,
#   tx_id: integer,
#   author: varchar,
#   permlink: varchar_max,
#   timestamp: datetime
# )
