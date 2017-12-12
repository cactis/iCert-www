class Toggling < Treeing
  belongs_to :user, foreign_key: "tree_id", foreign_type: "User"
end
