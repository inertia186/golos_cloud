module GolosCloud
  module Tx
    class Vote < GolosCloud::SqlBase

      self.table_name = :TxVotes
    
    end
  end
end

# Structure
#
# GolosCloud::Tx::Vote(
#   ID: integer,
#   tx_id: integer,
#   voter: varchar,
#   author: varchar,
#   permlink: varchar,
#   weight: integer,
#   timestamp: datetime
# )
