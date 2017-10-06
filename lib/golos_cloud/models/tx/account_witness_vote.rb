module GolosCloud
  module Tx
    class AccountWitnessVote < GolosCloud::SqlBase

      self.table_name = :TxAccountWitnessVotes

    end
  end
end

# Structure
#
# GolosCloud::Tx::AccountWitnessVote(
#   ID: integer, 
#   tx_id: integer, 
#   account: varchar, 
#   witness: varchar, 
#   approve: boolean, 
#   timestamp: datetime
# )
