unit module Multibase;
use Base58;

our proto decode($ --> Blob) {*}

multi decode(Blob $b where $b[0] == 0) { $b.subbuf: 1 }
multi decode(Str $ where /^^F(<[0..9A..F]>**2)+$$/) {
  blob8.new: $0.map: { :16(~$_) }
}
multi decode(Str $ where /^^B(<[A..Z2..7=]>+)$$/) {
  given run qw{base32 -d}, :in, :out, :bin {
    .in.write: $0.Str.encode;
    .in.close;
    return blob8.new: .out.slurp: :close;
  }
}
multi decode(Str $ where /^^z(<@Base58::alphabet>*)$$/) {
  Base58::decode $0.Str;
}
multi decode(Str $ where /^^M(<+alnum+[-_=]>+)$$/) {
  given run qw{base64 -d}, :in, :out, :bin {
    .in.write: $0.Str.encode;
    .in.close;
    return blob8.new: .out.slurp: :close;
  }
}

