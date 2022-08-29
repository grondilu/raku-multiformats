#!/usr/bin/env raku
unit module Multihash;

our proto sha1($ --> blob8) {*}
our proto sha256($ --> blob8) {*}
our proto sha512($ --> blob8) {*}
our proto sha3($ --> blob8) {*}

sub dgst(Blob $b, Str :$name where <sha1 sha256 sha512>.any) {
  given run qqw{openssl dgst -$name -binary}, :bin, :in, :out {
    .in.write: $b;
    .in.close;
    return .out.slurp(:close);
  }
}
multi sha1  (Str $s) { samewith $s.encode }
multi sha256(Str $s) { samewith $s.encode }
multi sha512(Str $s) { samewith $s.encode }

multi sha1  (Blob $b) { blob8.new: 0x11, 0x14, dgst($b, name => 'sha1'  )              .list }
multi sha256(Blob $b) { blob8.new: 0x12, 0x20, dgst($b, name => 'sha256')              .list }
multi sha512(Blob $b) { blob8.new: 0x13, 0x20, dgst($b, name => 'sha512').subbuf(0, 32).list }

# vi: ft=raku
