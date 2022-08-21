unit module MultiBase;

use Base58;

our proto decode(Str $str where $str.ords[0] ~~ ^128) { blob8.new: {*} }

multi decode($ where /^^0 ([<[01]>**8]+)/)     { $0.map: {  :2(~$_) } }
multi decode($ where /^^f (<[0..9a..f]>**2)*/) { $0.map: { :16(~$_) } }
multi decode($ where /^^F (<[0..9A..F]>**2)*/) { $0.map: { :16(~$_) } }
multi decode($ where /^^z (<@Base58::alphabet>*)/) { Base58::decode ~$0 }
