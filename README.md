# Multiformats in raku

See [multiformats](https://multiformats.io).

## Synopsis

```raku
use MultiBase;

say MultiBase::encode "Hello 😄 ",    :base58;      # zStV1DL6DB8sfxsZ
say MultiBase::encode "bonjour 😉  ", :base16upper; # F626F6E6A6F757220F09F988920

say Multiformats::decode "MYnllIPCfkYsg"; # bye 👋 
```
