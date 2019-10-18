<?php
require('vendor/autoload.php');

use Jose\Component\Core\AlgorithmManager;
use Jose\Component\KeyManagement\JWKFactory;
use Jose\Component\Signature\Algorithm\ES256;
use Jose\Component\Signature\JWSBuilder;
use Jose\Component\Signature\Serializer\CompactSerializer;


# Save your private key from Apple in a file called `key.txt`
$key_file = 'key.txt';

# Your 10-character Team ID
$team_id = '';

# Your Services ID, e.g. com.aaronparecki.services
$client_id = '';

# Find the 10-char Key ID value from the portal
$key_id = '';

$algorithmManager = new AlgorithmManager([new ES256()]);
$jwsBuilder = new JWSBuilder($algorithmManager);

$jws = $jwsBuilder
  ->create()
  ->withPayload(json_encode([
    'iat' => time(),
    'exp' => time() + 86400*180,
    'iss' => $team_id,
    'aud' => 'https://appleid.apple.com',
    'sub' => $client_id
  ]))
  ->addSignature(JWKFactory::createFromKeyFile($key_file), [
    'alg' => 'ES256',
    'kid' => $key_id
  ])
  ->build();

$serializer = new CompactSerializer();
$token = $serializer->serialize($jws, 0);

echo $token."\n";

