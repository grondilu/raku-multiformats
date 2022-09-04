# Multiformats in raku

See [multiformats](https://multiformats.io).

## Synopsis

```raku
use Multibase;

say Multibase::encode "Hello 😄 ",    :base58btc;      # zStV1DL6DB8sfxsZ
say Multibase::encode "bonjour 😉  ", :base16upper;    # F626F6E6A6F757220F09F988920

say Multibase::decode("MYnllIPCfkYsg").decode("utf8"); # bye 👋 
```
