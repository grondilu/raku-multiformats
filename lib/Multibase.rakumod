unit module Multibase;
use Base58;
package Base256Emoji {
  our constant @alphabet = < ๐ ๐ช โ ๐ฐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ โ
    ๐ป ๐ฅ ๐พ ๐ฟ ๐ โค ๐ ๐คฃ ๐ ๐ ๐ ๐ญ ๐ ๐ ๐ ๐ ๐ ๐ฅ ๐ฅฐ ๐ ๐ ๐ ๐ข ๐ค ๐ ๐ ๐ช
    ๐ โบ ๐ ๐ค ๐ ๐ ๐ ๐ ๐น ๐คฆ ๐ ๐ โ โจ ๐คท ๐ฑ ๐ ๐ธ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐ ๐คฉ
    ๐ ๐ ๐ค ๐ ๐ฏ ๐ ๐ ๐ถ ๐ ๐คญ โฃ ๐ ๐ ๐ ๐ช ๐ ๐ฅ ๐ ๐ ๐ฉ ๐ก ๐คช ๐ ๐ฅณ ๐ฅ ๐คค ๐
    ๐ ๐ณ โ ๐ ๐ ๐ด ๐ ๐ฌ ๐ ๐ ๐ท ๐ป ๐ โญ โ ๐ฅบ ๐ ๐ ๐ค ๐ฆ โ ๐ฃ ๐ ๐ โน ๐ ๐
    ๐  โ ๐ ๐บ ๐ ๐ป ๐ ๐ ๐ ๐ ๐น ๐ฃ ๐ซ ๐ ๐ ๐ต ๐ค ๐ ๐ด ๐ค ๐ผ ๐ซ โฝ ๐ค โ ๐
    ๐คซ ๐ ๐ฎ ๐ ๐ป ๐ ๐ถ ๐ ๐ฒ ๐ฟ ๐งก ๐ โก ๐ ๐ โ โ ๐ ๐ฐ ๐คจ ๐ถ ๐ค ๐ถ ๐ฐ ๐ ๐ข
    ๐ค ๐ ๐จ ๐จ ๐คฌ โ ๐ ๐บ ๐ค ๐ ๐ ๐ฑ ๐ ๐ถ ๐ฅด โถ โก โ ๐ ๐ธ โฌ ๐จ ๐ ๐ฆ ๐ท ๐บ โ  ๐
    ๐ ๐ต ๐ ๐คฒ ๐ค  ๐คง ๐ ๐ต ๐ ๐ง ๐พ ๐ ๐ ๐ค ๐ ๐คฏ ๐ท โ ๐ง ๐ฏ ๐ ๐ ๐ค ๐ ๐ โ ๐ด
    ๐ฃ ๐ธ ๐ ๐ ๐ฅ ๐คข ๐ ๐ก ๐ฉ ๐ ๐ธ ๐ป ๐ค ๐คฎ ๐ผ ๐ฅต ๐ฉ ๐ ๐ ๐ผ ๐ ๐ฃ ๐ฅ >;
}


our proto decode($ --> Blob) {*}
our proto encode(Blob $, *%) {*}
multi encode(Str $s, *%h) { samewith $s.encode, |%h }

multi encode($b, :$identity!) { $b.new: 0, $b.list }
multi encode($b, :$base16upper!) { 'F' ~ $b>>.fmt("%02X").join }
multi encode($b, :$base58btc!)   { 'z' ~ Base58::encode $b }
multi encode($b, :$base64pad!)   {
  given run qw{basenc --base64url}, :in, :out {
    .in.write: $b; .in.close;
    return 'M' ~ .out.slurp(:close).trim;
  }
}
multi encode($b, :$base32upper!)   {
  given run qw{basenc --base32}, :in, :out {
    .in.write: $b; .in.close;
    return 'B' ~ .out.slurp(:close).trim.uc;
  }
}
multi encode(Blob $b, :$base256emoji!) { '๐' ~ @Base256Emoji::alphabet[@$b].join; }

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
  given run qw{basenc --base64url -d}, :in, :out, :bin {
    .in.write: $0.Str.encode;
    .in.close;
    return blob8.new: .out.slurp: :close;
  }
}
multi decode(Str  $ where /^^'๐'/) {
  blob8.new: %(@Base256Emoji::alphabet.pairs.invert){$/.postmatch.comb};
}
