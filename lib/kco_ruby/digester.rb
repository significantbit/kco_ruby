require 'digest'
module KcoRuby
  #Creates a digester proc
  def self.create_digester(secret)
    lambda { |string|
      digest = Digest::SHA2.new
      if string
        digest.update(string)
      end
      digest.update(secret)
      digest.base64digest
    }
  end
end

