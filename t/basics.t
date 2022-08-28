#!/usr/bin/env raku
use Multibase;
use Test;

constant $expected-result = 'Multibase is awesome! \o/';

plan 4;
for <
  F4D756C74696261736520697320617765736F6D6521205C6F2F
  BJV2WY5DJMJQXGZJANFZSAYLXMVZW63LFEEQFY3ZP
  zYAjKoNbau5KiqmHPmSxYCvn66dA1vLmwbt
  MTXVsdGliYXNlIGlzIGF3ZXNvbWUhIFxvLw==
> {
  is Multibase::decode($_).decode, $expected-result;
}


# vi: ft=raku
