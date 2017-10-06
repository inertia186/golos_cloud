module GolosCloud
  module Tx
    class Custom::Witness < GolosCloud::Tx::Custom
      default_scope { where(tid: :witness) }
      
      scope :account, lambda { |account|
        where("JSON_VALUE(json_metadata, '$[1].account') = ?", account)
      }
    end
  end
end
