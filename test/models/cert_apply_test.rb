require 'test_helper'

class CertApplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: cert_applies
#
#  id              :integer          not null, primary key
#  Apply_No        :integer
#  Apply_Type      :string(255)
#  Apply_DateTime  :datetime
#  Apply_EmpNo     :string(255)
#  Cert_TypeId     :string(255)
#  Dflag           :string(255)
#  Clas_Id         :string(255)
#  Cert_OrgNo      :integer
#  Finished        :string(255)
#  Finish_DateTime :datetime
#  Finish_Emp      :string(255)
#  P_para          :string(255)
#  Chk_DateTime    :datetime
#  Chk_Emp         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
