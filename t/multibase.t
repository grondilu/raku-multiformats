#!/usr/bin/env raku
use Multibase;
use Test;

constant $test-string = 'Multibase is awesome! \o/';

plan 8;
for 
  base16upper => 'F4D756C74696261736520697320617765736F6D6521205C6F2F',
  base32upper => 'BJV2WY5DJMJQXGZJANFZSAYLXMVZW63LFEEQFY3ZP',
  base58btc   => 'zYAjKoNbau5KiqmHPmSxYCvn66dA1vLmwbt',
  base64pad   => 'MTXVsdGliYXNlIGlzIGF3ZXNvbWUhIFxvLw=='
{
  is Multibase::decode(.value).decode, $test-string;
  is Multibase::encode($test-string.encode, |(.key => True)), .value;
}


# vi: ft=raku
