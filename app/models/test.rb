class Test < User

    def self.seeds
        Course.destroy_all
        Cert.destroy_all

        limit = 20
        CertDetail.limit(limit).each_with_index do |data, index|
          params = Course.seed_params 
          params[:title] = data.CLAS_NAME 
          ap params
          course = Course.create(params)
          if index < limit / 2
          course.finish!
          if cert = course.cert
            cert.confirm!
          end
        end
        end
        "end"
    end

  def self.run
    reset_data!
    user = User.seed!
    # 一門結束課程
    5.times.each do
        course = Course.seed!
        course.finish!

        if cert = course.cert
            cert.confirm!
        end
        # exit if cert
    end

    # cert.course.finish!

    # paper = cert.papers.create!

    # paper = cert.papers.create!
    # paper.pay!

    # paper = cert.papers.create!
    # paper.pay!
    # paper.printout!

    # paper = cert.papers.create!
    # paper.pay!
    # paper.printout!
    # paper.deliver!

    # paper = cert.papers.create!
    # paper.pay!
    # paper.printout!
    # paper.deliver!
    # paper.receive!

    # paper = cert.papers.create!
    # paper.pay!
    # paper.printout!
    # paper.deliver!
    # paper.receive!
    # paper.rate!


    # Cert.second.confirm!
    # cert.print!

    # cert = Cert.second
    # cert.confirm!
end

def self.reset_data!
    # Cert.destroy_all

    User.destroy_all

    Udollar.destroy_all

  #   1.times.each do |index|
  #     User.seed! index
  # end

  Course.destroy_all
  0.times.each do |index|
      Course.seed! index
  end


end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  token                  :string(255)
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  aasm_state             :string(255)
#  settings               :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
