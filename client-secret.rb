require 'jwt'

# Save your private key from Apple in a file called `key.txt`

ecdsa_key = OpenSSL::PKey::EC.new IO.read 'key.txt'

claims = {
  'iss' => '',                          # Your 10-character Team ID
  'iat' => Time.now.to_i,
  'exp' => Time.now.to_i + 86400*30,    # This will be valid for 30 days
  'aud' => 'https://appleid.apple.com', 
  'sub' => '',                          # Your Services ID, e.g. com.aaronparecki.services
}

token = JWT.encode claims, ecdsa_key, 'ES256'

puts token
