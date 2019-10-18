require 'jwt'

# Save your private key from Apple in a file called `key.txt`
key_file = 'key.txt'

# Your 10-character Team ID
team_id = ''

# Your Services ID, e.g. com.aaronparecki.services
client_id = ''

# Find the 10-char Key ID value from the portal
key_id = ''

ecdsa_key = OpenSSL::PKey::EC.new IO.read key_file

headers = {
  'kid' => key_id
}

claims = {
  'iss' => team_id,
  'iat' => Time.now.to_i,
  'exp' => Time.now.to_i + 86400*180,   # This will be valid for 180 days
  'aud' => 'https://appleid.apple.com',
  'sub' => client_id,
}

token = JWT.encode claims, ecdsa_key, 'ES256', headers

puts token
