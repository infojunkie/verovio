# @music-i18n/verovio
Forked version of Verovio that includes music-i18n fixes. Music internationalization refers to the process of adapting music software to work with non-Western Common Practice structures, such as microtonality.

Verovio is a fast, portable and lightweight library for engraving [Music Encoding Initiative (MEI)](http://www.music-encoding.org) music scores into SVG.

See it running in the [browser](https://blog.karimratib.me/demos/musicxml/) and check out the [tutorial](http://www.verovio.org/tutorial.xhtml) for its web integration and for enabling user interaction.

## This fork

This fork is about adding full support for ["music-i18n" (music internationalization)](https://blog.karimratib.me/2018/01/05/music-l10n.html) to Verovio. This includes:

- Supports all SMuFL accidental glyphs. Not all bundled fonts support these glyphs, so make sure to use Bravura.
- Fixes MIDI SysEx export which is [broken on the main trunk](https://github.com/rism-digital/verovio/issues/4145).
- Supports [MEI temperaments](https://music-encoding.org/guidelines/v5/data-types/data.TEMPERAMENT.html) for MusicXML via the element [`sound/play/other-play[@type = "tuning-mei"]`](https://www.w3.org/2021/06/musicxml40/musicxml-reference/elements/other-play/)
- Supports full microtonality via [Ableton ASCL tunings](https://help.ableton.com/hc/en-us/articles/10998372840220-ASCL-Specification) for both MEI (via option `tuningFile`) and MusicXML (via both option `tuningFile` and MusicXML element [`sound/play/other-play[@type = "tuning-ableton"]`](https://www.w3.org/2021/06/musicxml40/musicxml-reference/elements/other-play/)).

## Basic usage

The recommended usage of the package is with ESM. Use `.mjs` as file extension when using this directly in Node.js or set `"type": "module"` in your `package.json`.

```js
import createVerovioModule from 'verovio/wasm';
import { VerovioToolkit } from 'verovio/esm';

const VerovioModule = await createVerovioModule();
const vrv = new VerovioToolkit(VerovioModule);
vrv.setOptions({
   tuningFile: await (await fetch('/path/to/tuning.ascl')).text(),
   font: 'Bravura',
});
vrv.loadData(await (await fetch('/path/to/score.mei')).text());
const svg = vrv.renderToSVG();
const midi = vrv.renderToMIDI();
```
