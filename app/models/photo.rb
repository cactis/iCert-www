class Photo < Image
  def cert_id=(value)
    self.assetable_id = value
    self.assetable_type = "Cert"
  end

  def self.seed_params(index = 0)
    {
      # remote_file_url: Faker::Company.logo
      remote_file_url: %w(
      http://www.certificatestemplate.com/wp-content/uploads/2017/03/stock-vector-certificate-of-achievement-blank-pdf.jpg
      https://www.creativecertificates.com/wp-content/uploads/2015/06/certificate-template-12.jpg
      https://i.pinimg.com/originals/74/70/64/74706434907fa8bf5dae8bf847a57a8f.jpg
      ).sample
    }
  end
end
