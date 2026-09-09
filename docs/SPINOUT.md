# Spinout And Architecture Execution

Extraction should produce the selected company architecture, not a perpetual Foundry fork and not always an independent spinout.

External reliance triggers an architecture review. The Company Pack records the current hypothesis and final decision under `formation_architecture`.

Planned execution commands:

```sh
bin/factory extract methaneproof --architecture independent ../MethaneProof
bin/factory extract methaneproof --architecture licensed-newco ../MethaneProof
bin/factory extract fieldproof --architecture parent-platform ../FieldProof
bin/factory extract aglend --architecture controlled-subsidiary ../AgLend
bin/factory retain supplierevidence --architecture internal-product
```

For extracted ventures, the target repo should contain the assets allowed to cross the boundary:

- product configuration
- application code
- protocol references
- company docs
- sales/account material
- investor material
- design material
- research memory
- provenance files
- license and improvement obligations

For retained ventures, the parent should keep the application, network, institutional graph, and reusable intelligence in Foundry or a successor parent operating surface.

After extraction, an external company should consume AgEvidence through versioned schemas, SDK packages, verifier releases, protocol releases, and conformance suites rather than repeatedly merging the whole Foundry repo.
