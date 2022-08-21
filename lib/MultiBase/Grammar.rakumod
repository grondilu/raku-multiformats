unit grammar MultiBase::Grammar;
use Base58;

token TOP {
  :my Str $*PREFIX;
  <base-identifier>
  <base-encoded-data>?
}
token base-identifier {
  . <?{ $/.Str.ord ~~ ^128 }> { $*PREFIX = ~$/ }
}
token base-encoded-data {
  | <?{ $*PREFIX eq 'f' }> <hex-lower-case>
  | <?{ $*PREFIX eq 'F' }> <hex-upper-case>
  | <?{ $*PREFIX eq 'z' }> <base58btc>
}

token hex-lower-case { [ $<byte> = <[0..9a..f]>**2 ]+ }
token hex-upper-case { [ $<byte> = <[0..9A..F]>**2 ]+ }
token base58btc { <@Base58::alphabet>+ }
