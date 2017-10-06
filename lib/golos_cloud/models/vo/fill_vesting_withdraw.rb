module GolosCloud
  module Vo
    class FillVestingWithdraw < GolosCloud::SqlBase

      self.table_name = :VOFillVestingWithdraws

    end
  end
end

# Structure
#
# GolosCloud::Vo::FillVestingWithdraw(
#   ID: integer,
#   block_num: integer,
#   timestamp: datetime,
#   from_account: varchar,
#   to_account: varchar,
#   withdrawn: varchar,
#   deposited: varchar
# )
