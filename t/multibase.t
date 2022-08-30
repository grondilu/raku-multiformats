#!/usr/bin/env raku
use Multibase;
use Test;


subtest "https://www.ietf.org/archive/id/draft-multiformats-multibase-04.html", {
  constant $test-string = 'Multibase is awesome! \o/';

  for
    base16upper => 'F4D756C74696261736520697320617765736F6D6521205C6F2F',
    base32upper => 'BJV2WY5DJMJQXGZJANFZSAYLXMVZW63LFEEQFY3ZP',
    base58btc   => 'zYAjKoNbau5KiqmHPmSxYCvn66dA1vLmwbt',
    base64pad   => 'MTXVsdGliYXNlIGlzIGF3ZXNvbWUhIFxvLw=='
    {
      is Multibase::decode(.value).decode, $test-string;
      is Multibase::encode($test-string.encode, |(.key => True)), .value;
    }

}

subtest "https://github.com/multiformats/multibase/blob/master/tests/basic.csv", {

  constant $test-string = 'yes mani !';

  for 
    base2 => '001111001011001010111001100100000011011010110000101101110011010010010000000100001',
    base8 => '7362625631006654133464440102',
    base16upper => 'F796573206D616E692021',
    base58btc => 'z7paNL19xttacUY',
    base256emoji => '🚀🏃✋🌈😅🌷🤤😻🌟😅👏'
    {
	if .key ~~ <base16upper base58btc base256emoji>.any {
	  is Multibase::decode(.value).decode, $test-string;
	  is Multibase::encode($test-string.encode, |(.key => True)), .value;
	}
	else { skip .key }
    }

}
done-testing;
# vi: ft=raku
