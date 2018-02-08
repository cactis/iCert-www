require 'active_support'
require 'active_support/deprecation'
require 'base64'
class Test < User



  def self.export(cert = Cert.first, tempfile)
    template = Template.first
    # cert = Cert.first
    course = cert.course
    svg = template.data
    svg.gsub!('/seeds/', '/home/ctslin/www/icert/public/seeds/')

    dom = Nokogiri::XML svg
    texts = dom.css('svg tspan')
    texts.each do |text|
      express = text.text
      log express, 'express 111'
      course.settings.each do |key, value|
        # log [key, value]
        field = '#{' + key + '}'
        express.gsub!(field, value.to_s)
      end
      size = 30
      log express, 'express 222'
      result = express.scan(/.{1,#{size}}/)
      log result, 'result'
      result = result.join("\n")
      log result, 'result  3333'
      express = result if result != ""
      svg.gsub! text, express
    end
    # log svg, 'svg'
    images = dom.css('svg image')
    link = images.first.get_attribute 'xlink:href'
    # return svg_to_img svg, link, tempfile
    return mini_magick_export svg, link, tempfile
  end

  def self.mini_magick_export(svg, bg, file)
    log svg, svg
    dom = Nokogiri::XML svg
    texts = dom.css('svg text')
    log texts, 'texts'

    image = MiniMagick::Image.open(bg)
    font_index = 0
    image.combine_options do |c|
      texts.each do |text|
        tspan = text.css('tspan').first
        log tspan, 'tspan'
        x = text.get_attribute('x').to_i
        y = text.get_attribute('y').to_i + tspan.get_attribute('dy').to_i# / 2
        # x = x - image.width / 2
        # y = y - image.height / 2
        # log x, y
        size = text.get_attribute('font-size')

        # log size, 'size'
        font = text.get_attribute('family')
        words = tspan.text
        c.fill 'black'

        # fonts = Settings.fonts.name.split(', ')
        # font = fonts[font_index]
        # size = 30
        # words = "#{font} #{Settings.fonts.labels.split(', ')[font_index]}"


        # log font, 'font'
        c.font font
        c.pointsize size
        c.interline_spacing size.to_i * 0.8
        # c.gravity "center"
        # c.size "#{size}x"
        # log Settings.fonts.labels, 'labels'
        log [x, y, size, font, words]
        # c.annotate "#{x}, #{y}", words
        c.draw "text #{x},#{y} '#{words}'"

        font_index = font_index == fonts.size - 1 ? 0 : font_index + 1
      end
    end
    image.write file
    file_url = file.gsub('/home/ctslin/www/icert/public', Settings.host)
    log file_url, 'file_url'
    return file_url
  end

  def self.svg_to_img(svg, bg, file)
    require "rmagick"
    # svg.gsub!(/^data:image\/(png|jpg|jpeg);base64,/,"")
    # file = tempfile # "#{Rails.root}/public/uploads/sample.png"
    # bg_url = "http://140.137.207.47/seeds/CCB5.png"
    # log svg, 'svg'
    # svg = Base64.decode64(svg)
    # log file, 'file'
    log svg, 'svg'
    img = Magick::Image.from_blob(svg) {
      self.format = 'SVG'
      self.background_color = 'transparent'
    }
    canvas = img.first

    # dom = Nokogiri::XML svg
    # texts = dom.css('svg tspan')
    # drawing = Magick::Draw.new
    # position = 80
    # texts.each do |text|
    #   text.text.scan("\n").each do |row|
    #     drawing.annotate(canvas, 0, 0, 200, position += 20, row)
    #   end
    # end
    canvas.to_blob {
      self.format = 'PNG'
    }
    # log file, 'save'
    canvas.write file

    image_list = Magick::ImageList.new(bg, file)
    File.delete file
    image_list.write file
    `convert #{Rails.root}/public/uploads/cert-0.png #{Rails.root}/public/uploads/cert-1.png -composite #{file}`

    file_url = file.gsub('/home/ctslin/www/icert/public', Settings.host)
    log file_url, 'file_url'
    return file_url
  end

#   def overlay
#   ruby = Image.read(‘public/images/ruby.jpg’)[0] #This returns an Array! Get the first element.
# rails = Image.read(‘public/images/rails.png’)[0]
# rails_on_ruby = ruby.composite(rails, Magick::EastGravity, 0, 0, Magick::OverCompositeOp) #the 0,0 is the x,y
# rails_on_ruby.format = ‘jpeg’
# send_data rails_on_ruby.to_blob, :stream => ‘false’, :filename => ‘test.jpg’, :type => ‘image/jpeg’, :disposition => ‘inline’
# end



def self.run
  reset_data!
  3.times.each do |i|
    user = User.seed! i
  end
  log User.count
    # 一門結束課程
    3.times.each do
      Template.seed!
    end
    5.times.each do
      course = Course.seed!
        # course.finish!
        # if cert = course.cert
        #     cert.confirm!
        # end
        # exit if certC
      end

      course = Course.first
      template = Template.first
      course_template = course.course_templates.new(CourseTemplate.seed_params)
    # course_template.course = course
    course_template.template = template
    course_template.save

    cert = Cert.seed!
    `open #{Settings.host}/api/certs/#{cert.id}/demo`

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
    Cert.destroy_all
    Template.destroy_all
    Course.destroy_all

    User.destroy_all

    Udollar.destroy_all

    #   1.times.each do |index|
    #     User.seed! index
    # end

    # 0.times.each do |index|
    #   Course.seed! index
    # end


  end

  def self.seeds
    Cert.destroy_all
    Course.destroy_all

    3.times.each do |i|
      user = User.seed!
    end

    3.times.each do
      Template.seed!
    end

    limit = 5
    CertDetail.limit(limit).each_with_index do |data, index|
      params = Course.seed_params
      params[:title] = data.CLAS_NAME
      params[:CLAS_ID] = data.CLAS_ID
      params[:STUD_ID] = data.STUD_ID
      params[:STUD_NO] = data.STUD_NO
      params[:STUD_NAME] = data.STUD_NAME
      params[:ITEM_NO] = data.ITEM_NO
      params[:ITEM_NAME] = data.ITEM_NAME
      params[:CLAS_NAME] = data.CLAS_NAME
      params[:CLAS_SERIAL] = data.CLAS_SERIAL
      params[:ITEM_POINT] = data.ITEM_POINT
      params[:MASTER_NO] = data.MASTER_NO
      params[:CLS_POINTS] = data.CLS_POINTS
      params[:ENG_NAME] = data.ENG_NAME
      params[:STUD_ENGNAME] = data.STUD_ENGNAME
      params[:BIRTH] = data.BIRTH
      params[:SEX] = data.SEX
      params[:CLAS_ENGNAME] = data.CLAS_ENGNAME
      params[:BUDG_MONTH] = data.BUDG_MONTH
      params[:BUDG_YEAR] = data.BUDG_YEAR
      params[:BUDG_ACTUOPENDATE] = data.BUDG_ACTUOPENDATE
      params[:CLAS_WORD] = data.CLAS_WORD
      params[:CLAS_ENDDATE] = data.CLAS_ENDDATE
      params[:SNO] = data.SNO
      params[:ABS_HOUR] = data.ABS_HOUR
      params[:BUDG_TOTALHOURS] = data.BUDG_TOTALHOURS
      params[:BUDG_HOURCOUNT] = data.BUDG_HOURCOUNT
      params[:GRP_SNO] = data.GRP_SNO
      params[:scls_id] = data.scls_id
      params[:MEMO] = data.MEMO
      params[:REQUIRED] = data.REQUIRED
      params[:TERM] = data.TERM
      params[:OPEN_DATE] = data.OPEN_DATE
      params[:END_DATE] = data.END_DATE
      params[:OUT_SNO] = data.OUT_SNO
      params[:GRAD_SIGN] = data.GRAD_SIGN

      course = Course.create(params)
      if index < limit / 2
        course.finish!
        if cert = course.cert
          cert.confirm!
        end
      end
    end
    log [Course.count, CourseUser.count, Cert.count], "[Course.count, CourseUser.count, Cert.count]"
  end

  HEADER = 'data:image/png;base64,'
  def self.svg_process(svg)

    svg = Nokogiri::XML svg
    images = svg.css('svg image')
    log images, 'images'
    images.each do |svgImage|

      # base64img = (svgImage.get_attribute 'xlink:href')[(HEADER.length)..-1]
      base64img = svgImage.get_attribute 'xlink:href'
      log base64img, 'base64img'
      blob = Base64.decode64(base64img)
      log blob, 'blob'
      image = MiniMagick::Image.read blob
      image.colorspace 'rgb'

      base64img = Base64.encode64(image.to_blob)
      svgImage.set_attribute 'xlink:href', "#{HEADER}#{base64img}"

    end

    svg.to_s
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
