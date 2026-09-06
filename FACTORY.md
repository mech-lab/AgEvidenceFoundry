# AgEvidence Foundry

AgEvidence owns the evidence substrate. Foundry owns company formation. Individual companies own their vertical differentiation.

The Foundry architecture is:

```text
meronrudy/AgEvidence
        |
        | upstream protocol + trust substrate
        v
mech-lab/AgEvidenceFoundry
        |
        | factory + declarative venture packs
        +-- ventures/methaneproof
        +-- ventures/fieldproof
        +-- ventures/aglend
        +-- ventures/supplierevidence
```

Foundry proves the thesis by letting one evidence grammar produce multiple independently financeable companies.

## Repository Roles

`protocol/`, `packages/`, and the generic Rails evidence workflow remain recognizable AgEvidence substrate.

`factory/` contains the machinery for loading, validating, generating, and eventually extracting companies.

`commercial/` contains the reusable commercial and company-formation grammar: brand, claim discipline, account records, contact roles, triggers, offers, scoring, discovery, pitch templates, source ledgers, and formation experiments.

`ventures/` contains Company Packs. Each pack owns the vertical product delta plus brand, GTM, account, research, pitch, and formation state.

## Company Pack Contract

Every company has `ventures/<venture>/company.yml`.

The company pack declares:

- company identity and independence model
- category descriptor
- initial buyer and relying parties
- problem
- first reliance event
- artifact that matters
- land motion
- primary offer
- AgEvidence endorsement mode

Under it:

```text
product/    technical Venture Pack
brand/      naming, visual DNA, vocabulary, claim discipline
gtm/        ICP, pricing, offers, channels, objections, discovery, scoring
accounts/   account universe, contacts, relationships, triggers
pitch/      audience-specific pitch facts and proof points
research/   sources, hypotheses, decisions
formation/  founder, gates, milestones, experiments
generated/  disposable compiled artifacts
```

## Venture Pack Contract

Every company also has a product Venture Pack at `ventures/<venture>/product/venture.yml`.

The pack declares:

- protocol compatibility
- market and buyer category
- terminology
- feature capabilities
- ProgramProfiles
- integrations
- acceptance gates
- reliance gate

The Rails app should depend on `Factory::VenturePack.current`, not on hard-coded venture names. Shared code should ask questions such as:

```ruby
Factory::VenturePack.current.term(:artifact)
Factory::VenturePack.current.enabled?(:verification)
Factory::VenturePack.current.reliance_contract
```

Avoid `if company == "MethaneProof"` in shared application code.

## CLI

The factory CLI starts with:

```sh
bin/factory list
bin/factory show methaneproof
bin/factory doctor methaneproof
bin/factory doctor methaneproof --verbose
bin/factory brand score methaneproof
bin/factory claims check methaneproof
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
bin/factory research stale methaneproof
bin/factory pitch customer methaneproof
bin/factory demo methaneproof
bin/factory test methaneproof
```

Future commands:

```sh
bin/factory new mycompany
bin/factory extract methaneproof ../MethaneProof
```

Extraction should produce a standalone company repo with explicit provenance files such as `AGEVIDENCE_BASE` and `FOUNDRY_ORIGIN`.

## Reliance Gate

Every venture defines a formal reliance gate. A working demo is not enough. A venture must declare the relying party, decision, required evidence controls, and success event.

This lets Foundry measure:

- time to runnable vertical
- time to first artifact
- time to first verification
- time to first reliance
- shared-code ratio

The invariant is: every supported venture can complete an end-to-end reliance path from the same substrate and carry enough commercial discipline to pursue that reliance event without inventing a company from scratch.
