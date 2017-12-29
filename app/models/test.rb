class Test < User

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
