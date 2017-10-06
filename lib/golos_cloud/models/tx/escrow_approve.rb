module GolosCloud
  module Tx
    class EscrowApprove < GolosCloud::SqlBase

      self.table_name = :TxEscrowApproves

    end
  end
end

# Structure
#
# GolosCloud::Tx::EscrowApprove(
#   ID: integer,
#   tx_id: integer,
#   from: varchar,
#   to: varchar,
#   agent: varchar,
#   who: varchar,
#   escrow_id: integer,
#   approve: boolean,
#   timestamp: datetime
# )
