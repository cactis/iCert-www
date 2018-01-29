class Tree < ApplicationRecord
end

# == Schema Information
#
# Table name: trees
#
#  id                :integer          not null, primary key
#  type              :string(255)
#  user_id           :integer
#  name              :string(255)      not null
#  title             :string(255)
#  alias             :string(255)
#  parent_id         :integer
#  lft               :integer          not null
#  rgt               :integer          not null
#  depth             :integer          default(0), not null
#  children_count    :integer          default(0), not null
#  ancestors_count   :integer          default(0), not null
#  descendants_count :integer          default(0), not null
#  active            :boolean          default(TRUE)
#  settings          :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_trees_on_lft                          (lft)
#  index_trees_on_parent_id                    (parent_id)
#  index_trees_on_rgt                          (rgt)
#  index_trees_on_type                         (type)
#  index_trees_on_type_and_parent_id_and_name  (type,parent_id,name) UNIQUE
#  index_trees_on_user_id                      (user_id)
#
