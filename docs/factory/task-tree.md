# Foundry Task Tree

This is the parent/child GitHub task tree for converting AgEvidenceFoundry into a thin factory fork.

## Epic: Thin Factory Fork

Goal: keep AgEvidence as the evidence substrate, Foundry as the company-formation layer, and venture/company repos as the vertical/proprietary layers.

## Epic: Company Operating System

Goal: let a domain founder inherit product substrate, commercial substrate, company identity, research memory, formation state, and a path to an independent company.

### C0: Promote Venture Pack To Company Pack

Files:

- `ventures/*/company.yml`
- `ventures/*/product/venture.yml`
- `factory/loaders/company_pack.rb`
- `factory/loaders/company_pack_loader.rb`
- `factory/conformance/company_pack_contract.rb`

Acceptance tests:

- `bin/factory doctor` validates Company Packs, not only technical Venture Packs.
- `Factory::VenturePack.current` still works for Rails.
- `Factory::CompanyPack` exposes the broader operating-system object.

### C1: Add Commercial Substrate

Files:

- `commercial/schemas/*.json`
- `commercial/vocabulary/*.yml`
- `commercial/scoring/reliance_account.yml`
- `commercial/templates/**`
- `commercial/graph/**`

Acceptance tests:

- Commercial schemas parse as JSON.
- Universal contact roles include EB, CH, TU, EX, IN, BL, PA, and EV.
- Evidence classes distinguish verified public signals, brief-derived claims, supplied research, and GTM inference.

### C2: Add Brand And Claim Discipline

Files:

- `ventures/*/brand/brand.yml`
- `ventures/*/brand/naming.yml`
- `ventures/*/brand/claim_discipline.yml`
- `ventures/*/brand/visual.yml`
- `factory/operations/brand_score.rb`
- `factory/operations/claims_checker.rb`

Acceptance tests:

- `bin/factory brand score methaneproof` prints a five-test scorecard.
- `bin/factory claims check methaneproof` scans generated copy for prohibited claims.
- `bin/factory doctor` fails when a company lacks claim discipline.

### C3: Add GTM Accounts, Scoring, And Hypotheses

Files:

- `ventures/*/gtm/**`
- `ventures/*/accounts/**`
- `factory/operations/gtm_validator.rb`
- `factory/operations/gtm_scorer.rb`
- `factory/operations/opportunity_hypothesis.rb`

Acceptance tests:

- `bin/factory gtm validate methaneproof` enforces dated triggers for Tier-1 accounts.
- `bin/factory gtm score methaneproof` computes account scores from cited score components.
- `bin/factory gtm hypothesis methaneproof sea_forest` renders a discovery-safe opportunity hypothesis.

### C4: Add Pitch, Research, And Formation State

Files:

- `ventures/*/pitch/**`
- `ventures/*/research/**`
- `ventures/*/formation/**`
- `factory/operations/pitch_renderer.rb`
- `factory/operations/research_staleness.rb`

Acceptance tests:

- `bin/factory pitch customer methaneproof` renders a customer narrative from structured facts.
- `bin/factory research stale methaneproof` reports current and stale commercial claims.
- `bin/factory doctor methaneproof --verbose` shows product, brand, GTM, pitch, and formation status.

### C5: Add Phase 0 Pricing Validation

Files:

- `ventures/*/gtm/validation/**`
- `ventures/*/gtm/pricing.yml`
- `commercial/schemas/pricing-*.schema.json`
- `commercial/schemas/phase-zero-*.schema.json`
- `factory/operations/validation_report.rb`

Acceptance tests:

- `bin/factory validation show methaneproof` reports problem, reliance, buyer, artifact, pricing, and result.
- `bin/factory validation pricing methaneproof` shows the pricing evidence ladder.
- `bin/factory validation gate methaneproof` requires budget owner, budget source, buying unit, price tests, and one P3/P4/P5 signal.
- `gtm/pricing.yml` contains current policy and points to `gtm/validation/pricing/hypothesis.yml` and `gtm/validation/pricing/synthesis.yml`.
- `bin/factory doctor` fails if a Company Pack treats Phase 0 pricing assumptions as validated market fact.

### F0: Sync Foundry With AgEvidence

Files:

- `UPSTREAM.md`
- `bin/sync-upstream`
- `.github/workflows/upstream-sync.yml`

Acceptance tests:

- `git remote -v` shows `upstream` as `https://github.com/meronrudy/AgEvidence`.
- `bin/sync-upstream` reports whether `main` is ahead/behind upstream.
- Fast-forward sync works when Foundry has no divergent commits.

### F1: Remove Noncanonical Application Paths

Files:

- Remove root `app/controllers/concerns/api_authentication.rb`.
- Remove root `db/seeds.rb`.
- Keep `apps/console/app/controllers/concerns/api_authentication.rb`.
- Keep `apps/console/db/seeds.rb`.
- Document the rule in `UPSTREAM.md`.

Acceptance tests:

- `find app db -type f` returns no root app or root db files.
- Rails tests still use `apps/console/` as the canonical app tree.

### F2: Add Factory Architecture And VenturePack Schema

Files:

- `FACTORY.md`
- `factory/README.md`
- `factory/schemas/venture-pack.schema.json`
- `factory/schemas/terminology.schema.json`
- `factory/schemas/integration.schema.json`
- `factory/schemas/reliance-gate.schema.json`
- `factory/loaders/venture_pack.rb`
- `factory/loaders/venture_pack_loader.rb`
- `factory/loaders/terminology_loader.rb`
- `factory/loaders/program_profile_loader.rb`
- `factory/conformance/venture_pack_contract.rb`
- `factory/conformance/factory_contract.rb`

Acceptance tests:

- `ruby factory/test/venture_pack_loader_test.rb` passes.
- `bin/factory doctor` validates every seed pack.
- Missing required manifest keys produce a contract failure.

### F3: Add Factory CLI

Files:

- `bin/factory`
- `factory/test/venture_pack_loader_test.rb`
- `.github/workflows/factory.yml`

Acceptance tests:

- `bin/factory list` prints all seed venture pack ids.
- `bin/factory show methaneproof --json` prints parseable JSON.
- `bin/factory doctor methaneproof` exits zero for a valid pack.
- `bin/factory doctor unknown` exits nonzero.

### F4: Convert MethaneProof Into First Executable Pack

Files:

- `ventures/methaneproof/product/venture.yml`
- `ventures/methaneproof/terminology.yml`
- `ventures/methaneproof/features.yml`
- `ventures/methaneproof/program_profiles/au_methane_intervention_v1.yml`
- `ventures/methaneproof/requirements/*.yml`
- `ventures/methaneproof/evidence_types/*.yml`
- `ventures/methaneproof/artifact_templates/methane_evidence_statement.yml`
- `ventures/methaneproof/seeds/demo.yml`
- `docs/venture-playbooks/methaneproof.md`

Acceptance tests:

- `bin/factory doctor methaneproof` passes.
- Pack declares a methane reliance gate for processor claim acceptance.
- Pack contains no duplicate Rails app, auth, verifier, SDK, or schema implementation.

### F5: Make Rails Boot With An Active Venture Pack

Files:

- `apps/console/config/initializers/factory_venture_pack.rb`
- `bin/factory demo`
- `bin/factory test`

Acceptance tests:

- `VENTURE_PACK=methaneproof bin/rails runner 'puts Rails.application.config.x.venture_pack.id'` prints `methaneproof`.
- `bin/factory demo methaneproof` boots the existing Rails app with `VENTURE_PACK=methaneproof`.
- Shared Rails code can read `Factory::VenturePack.current` without knowing the venture name.

### F6: Move Labels, Seeds, ProgramProfiles, And Requirements Behind Pack Loading

Files:

- `apps/console/app/helpers/application_helper.rb`
- `apps/console/app/views/shared/*`
- `apps/console/db/seeds.rb`
- `apps/console/app/models/program_profile.rb`
- `apps/console/app/models/requirement.rb`
- `factory/loaders/*`

Acceptance tests:

- Navigation and page labels use terminology from the active pack.
- Seed data changes when `VENTURE_PACK` changes.
- No shared app file contains `if company ==` or hard-coded venture ids.

### F7: Add FieldProof Pack

Files:

- `ventures/fieldproof/**`
- `docs/venture-playbooks/fieldproof.md`

Acceptance tests:

- `bin/factory doctor fieldproof` passes.
- FieldProof declares trial, treatment, control, site, season, measurement, protocol, and claim semantics as vertical configuration.

### F8: Remove Accidental Vertical Coupling From Base

Files:

- Shared app files discovered while comparing MethaneProof and FieldProof.
- `factory/conformance/venture_pack_contract.rb`

Acceptance tests:

- `bin/factory doctor methaneproof fieldproof` or the venture matrix passes.
- Searching shared app code finds no MethaneProof-only assumptions.
- Common code handles at least two materially different packs through the same interface.

### F9: Add SupplierEvidence Pack

Files:

- `ventures/supplierevidence/**`
- `docs/venture-playbooks/supplierevidence.md`

Acceptance tests:

- `bin/factory doctor supplierevidence` passes.
- Pack declares supplier passport, buyer package, assurance export, and corporate reporter reliance.

### F10: Add AgLend Pack

Files:

- `ventures/aglend/**`
- `docs/venture-playbooks/aglend.md`

Acceptance tests:

- `bin/factory doctor aglend` passes.
- AgLend keeps credit interpretation in the venture layer and does not add lending decisions to `protocol/`.

### F11: Add Four-Pack CI Matrix

Files:

- `.github/workflows/venture-matrix.yml`

Acceptance tests:

- CI validates `methaneproof`, `fieldproof`, `aglend`, and `supplierevidence`.
- Every pack must pass schema validation and structural reliance-gate validation.

### F12: Add `bin/factory new`

Files:

- `factory/generators/venture_generator.rb`
- `factory/templates/venture/**`
- `bin/factory`

Acceptance tests:

- `bin/factory new mycompany` creates `ventures/mycompany/`.
- The generated pack passes `bin/factory doctor mycompany` after required placeholders are completed.

### F13: Add `bin/factory extract`

Files:

- `factory/generators/extraction_generator.rb`
- `factory/conformance/extraction_contract.rb`
- `factory/templates/company/**`
- `bin/factory`

Acceptance tests:

- `bin/factory extract methaneproof ../MethaneProof` creates a standalone repo tree.
- Output includes `AGEVIDENCE_BASE` and `FOUNDRY_ORIGIN`.
- Output does not require remaining a perpetual Foundry fork.

### F14: Extract MethaneProof As First Company Repo

Files:

- `../MethaneProof/**`
- Foundry release notes.

Acceptance tests:

- MethaneProof standalone repo boots independently.
- MethaneProof provenance names the AgEvidence base SHA, Foundry release, and venture pack version.
- MethaneProof consumes future AgEvidence updates through versioned schemas, SDK packages, verifier releases, and conformance suites rather than permanent Foundry branch merging.
