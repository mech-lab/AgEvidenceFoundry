# Factory

`factory/` is the internal machinery for AgEvidence Foundry.

Foundry is the product and repository concept. Factory is the code that loads, validates, generates, and eventually extracts or retains companies according to their selected formation architecture.

## Contents

- `schemas/` defines the executable contract for venture packs and reliance gates.
- `loaders/` reads Company Pack and Venture Pack configuration from `ventures/`.
- `conformance/` validates pack structure and extraction outputs.
- `generators/` is reserved for pack generation, architecture-aware extraction, and retained-product compilation.
- `templates/` is reserved for generated company scaffolds.

## Current Commands

```sh
bin/factory list
bin/factory show methaneproof
bin/factory doctor methaneproof
bin/factory doctor
bin/factory doctor methaneproof --verbose
bin/factory brand score methaneproof
bin/factory claims check methaneproof
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
bin/factory validation show methaneproof
bin/factory validation interviews methaneproof
bin/factory validation pricing methaneproof
bin/factory validation gate methaneproof
bin/factory research stale methaneproof
bin/factory pitch customer methaneproof
bin/factory pitch investor methaneproof
bin/factory pitch founder methaneproof
bin/factory pitch architecture methaneproof
bin/factory demo methaneproof
bin/factory test methaneproof
```

`doctor` is intentionally dependency-light. It uses Ruby standard library YAML parsing, JSON schema subset validation, and structural contracts so pack validation can run before Rails or PostgreSQL is available.

## Boundary

Do not put company-specific evidence primitives in `protocol/`. Put vertical semantics in `ventures/<venture>/`.

Shared app code should use `Factory::VenturePack.current` for labels, capabilities, requirements, integrations, and reliance contracts.

Shared company-formation tooling should use `Factory::CompanyPack`.

`company.independence_model` remains a compatibility field. New architecture work should read `formation_architecture`, which records the provisional model, candidate architecture codes, customer rights, IP allocation, founder contribution, parent economics, and extraction mode.
