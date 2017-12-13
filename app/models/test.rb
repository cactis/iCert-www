class Test < User

  def self.run
    reset_data!


    # 一門結束課程
    cert = Cert.first
    cert.course.finish!
    # Cert.first.confirm!

    cert = Cert.second
    cert.course.finish!
    # Cert.second.confirm!
    # cert.print!

    # cert = Cert.second
    # cert.confirm!
  end

  def self.reset_data!
    # Cert.destroy_all
    Udollar.destroy_all

    User.destroy_all
    3.times.each do |index|
      User.seed! index
    end

    Course.destroy_all
    20.times.each do |index|
      Course.seed! index
    end


  end

end
