
class CertDetail < ApplicationRecord

  default_scope { order("id desc") }

  has_many :courses

  def self.import(records = CertDetail.limit(10))
    records.each do
    end
  end

  # after_update do |record|
  #   record.courses.each do |course|
  #     course.update_attribnutes!({STUD_NAME: record.STUD_NAME})
  #   end
  #   CourseTemplate.first.certs.each do |cert|
  #     cert.generate_photo!
  #   end
  #   # CourseTemplate.first.certs.each do |cert|
  #   #   cert.generate_photo!
  #   # end
  # end

  def BIRTH
    log self[:BIRTH].to_s, 'birth111'
    if t1 = self[:BIRTH].to_s
      if t2 = t1.split(' ')[0]
        if t = t2.split('-')
          "中華民國#{t[0].to_i - 1911}年#{t[1]}月#{t[2]}日"
        end
      end
    end
  end

  def self.seed_params
    if count > 0
      first.as_json
    else
      {
       CLAS_NAME: "法律研究所學分班",
       STUD_NAME: "林啟聰"
     }
   end
 end
end

# == Schema Information
#
# Table name: cert_details
#
#  id                :integer          not null, primary key
#  CLAS_ID           :string(255)
#  CLAS_NAME         :string(255)
#  CLAS_ENGNAME      :string(255)
#  STUD_ID           :string(255)
#  STUD_NO           :integer
#  STUD_NAME         :string(255)
#  SCORE             :integer
#  ITEM_NO           :string(255)
#  ITEM_NAME         :string(255)
#  CLAS_SERIAL       :integer
#  ITEM_POINT        :decimal(10, )
#  MASTER_NO         :string(255)
#  CLS_POINTS        :string(255)
#  ENG_NAME          :string(255)
#  STUD_ENGNAME      :string(255)
#  BIRTH             :datetime
#  SEX               :string(255)
#  BUDG_MONTH        :integer
#  BUDG_YEAR         :integer
#  BUDG_ACTUOPENDATE :datetime
#  CLAS_WORD         :string(255)
#  CLAS_ENDDATE      :datetime
#  SNO               :integer
#  ABS_HOUR          :integer
#  BUDG_TOTALHOURS   :decimal(10, )
#  BUDG_HOURCOUNT    :decimal(10, )
#  GRP_SNO           :integer
#  scls_id           :string(255)
#  MEMO              :string(255)
#  REQUIRED          :string(255)
#  TERM              :string(255)
#  OPEN_DATE         :datetime
#  END_DATE          :datetime
#  OUT_SNO           :string(255)
#  GRAD_SIGN         :string(255)
#  settings          :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
