module GolosCloud
  module Tx
    class WitnessUpdate < GolosCloud::SqlBase

    self.table_name = :TxWitnessUpdates

    end
  end
end

# Structure
#
# GolosCloud::Tx::WitnessUpdate(
#   ID: integer,
#   tx_id: integer,
#   owner: varchar,
#   url: varchar_max,
#   block_signing_key: varchar,
#   props_account_creation_fee: money,
#   props_maximum_block_size: integer,
#   props_sbd_interest_rate: integer,
#   fee: money,
#   timestamp: datetime
# )
