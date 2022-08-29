#!/usr/bin/env raku
use Multihash;
use Test;

constant input = 'Merkle–Damgård';

is Multihash::sha1(input), blob8.new(
  '11148a173fd3e32c0fa78b90fe42d305f202244e2739'.comb(2).map({:16($_)})
), 'SHA1';

is Multihash::sha256(input), blob8.new(
  '122041dd7b6443542e75701aa98a0c235951a28a0d851b11564d20022ab11d2589a8'.comb(2).map({:16($_)})
), 'SHA2-256 (aka SHA256)';

is Multihash::sha512(input), blob8.new(
  '132052eb4dd19f1ec522859e12d89706156570f8fbab1824870bc6f8c7d235eef5f4'.comb(2).map({:16($_)})
), 'SHA2-512 (aka SHA512)';

# vi: ft=raku
