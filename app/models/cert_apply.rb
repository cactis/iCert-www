class CertApply < ApplicationRecord
  # self.table_name "dbo_Cert_Apply"
end

# == Schema Information
#
# Table name: cert_applies
#
#  Apply_No        :integer
#  Apply_Type      :string(1)
#  Apply_DateTime  :datetime
#  Apply_EmpNo     :string(10)
#  Cert_TypeId     :string(5)
#  Dflag           :string(1)
#  Clas_Id         :string(10)
#  Cert_OrgNo      :integer
#  Finished        :string(1)
#  Finish_DateTime :datetime
#  Finish_Emp      :string(10)
#  P_para          :string(200)
#  Chk_DateTime    :datetime
#  Chk_Emp         :string(20)
#
