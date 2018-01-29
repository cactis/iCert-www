class Toggling < Treeing
  belongs_to :user, foreign_key: "tree_id", foreign_type: "User"
end

# == Schema Information
#
# Table name: treeings
#
#  id            :integer          not null, primary key
#  type          :string(255)
#  tree_type     :string(255)
#  tree_id       :integer
#  treeable_type :string(255)
#  treeable_id   :integer
#  value         :integer
#  settings      :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_treeings_on_tree_type_and_tree_id          (tree_type,tree_id)
#  index_treeings_on_treeable_type_and_treeable_id  (treeable_type,treeable_id)
#  index_treeings_on_type                           (type)
#
