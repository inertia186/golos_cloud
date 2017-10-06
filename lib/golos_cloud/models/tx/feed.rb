module GolosCloud
  module Tx
    class Feed < GolosCloud::SqlBase

      self.table_name = :TxFeeds

    end
  end
end

# Structure
#
# GolosCloud::Tx::Feed(
#   ID: integer,
#   tx_id: integer,
#   publisher: varchar,
#   exchange_rate_base: money,
#   exchange_rate_quote: money,
#   timestamp: datetime
# )
