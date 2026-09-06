# Spinout

Extraction should produce an operating company, not a perpetual Foundry fork.

At formation, `bin/factory extract <venture> <target-dir>` should generate a standalone repo containing:

- product configuration
- application code
- protocol references
- company docs
- sales/account material
- investor material
- design material
- research memory
- provenance files

After extraction, the company should consume AgEvidence through versioned schemas, SDK packages, verifier releases, protocol releases, and conformance suites rather than repeatedly merging the whole Foundry repo.
