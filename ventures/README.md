# Company Packs

Company packs are the executable operating objects for AgEvidence Foundry.

Each pack defines the company-specific product substrate, brand, GTM system, account universe, pitch facts, commercial evidence, and formation state.

The technical Venture Pack now lives under `product/`.

Current packs:

- `methaneproof`
- `fieldproof`
- `aglend`
- `supplierevidence`

Run:

```sh
bin/factory list
bin/factory show methaneproof
bin/factory doctor --verbose
bin/factory brand score methaneproof
bin/factory gtm score methaneproof
```

Keep generic evidence primitives, verifier semantics, SDK behavior, and Rails extension points out of company packs. Those belong upstream in AgEvidence.

Keep generated websites, decks, one-pagers, and PDFs out of source-of-truth files. Generated artifacts belong under `generated/` and can be recreated from structured pack data.
