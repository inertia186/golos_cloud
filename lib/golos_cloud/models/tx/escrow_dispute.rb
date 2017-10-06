module GolosCloud
  module Tx
    class EscrowDispute < GolosCloud::SqlBase

      self.table_name = :TxEscrowDisputes

    end
  end
end

# Structure
#
# GolosCloud::Tx::EscrowDispute(
#   ID: integer,
#   tx_id: integer,
#   from: varchar,
#   to: varchar,
#   agent: varchar,
#   who: varchar,
#   escrow_id: integer,
#   timestamp: datetime
# )
