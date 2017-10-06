module GolosCloud
  module Vo
    class ShutdownWitness < GolosCloud::SqlBase

      self.table_name = :VOShutdownWitnesses

    end
  end
end

# Structure
#
# GolosCloud::Vo::ShutdownWitness(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   owner: varchar
# )
