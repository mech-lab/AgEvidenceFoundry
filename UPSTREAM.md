# Upstream Policy

AgEvidenceFoundry is a thin factory fork of AgEvidence.

Canonical evidence infrastructure flows from:

```text
upstream = https://github.com/meronrudy/AgEvidence
origin   = https://github.com/mech-lab/AgEvidenceFoundry
```

Keep the remotes configured this way:

```sh
git remote add upstream https://github.com/meronrudy/AgEvidence
git remote set-url origin https://github.com/mech-lab/AgEvidenceFoundry
```

Sync before changing factory architecture:

```sh
bin/sync-upstream
```

`bin/sync-upstream` fetches upstream, reports divergence, and fast-forwards `main` when possible. If histories diverge, make an explicit sync branch such as `sync/upstream-2026-09-06` and resolve the merge as repository architecture work.

## Source Of Truth

| Change | Where it belongs |
| --- | --- |
| Canonical evidence primitive | AgEvidence |
| Canonical verifier semantics | AgEvidence |
| SDK functionality useful to every evidence company | AgEvidence |
| Generic Rails extension point | AgEvidence |
| Company-generation tooling | Foundry |
| VenturePack contract | Foundry |
| Cross-venture configuration tooling | Foundry |
| Methane requirement | MethaneProof pack |
| Trial efficacy workflow | FieldProof pack |
| Underwriting workflow | AgLend pack |
| Supplier passport | SupplierEvidence pack |
| Proprietary lender model | AgLend standalone repo |

Rule: generic goes upstream, factory-specific stays in Foundry, vertical goes in a venture pack, proprietary goes in the company repo after extraction.

## Protected Boundary

`protocol/` belongs to AgEvidence. It should hold canonical primitives, canonicalization, digest semantics, bundle structure, signature semantics, verification semantics, and conformance fixtures.

Foundry should not add company-specific schemas such as `aglend_credit_score` or `methaneproof_dose_compliance` under `protocol/` unless the concept has matured into an AgEvidence standard.

## Branch Policy

Use short-lived branches that merge back to `main`, for example:

```text
feat/factory-venture-pack-contract
feat/factory-cli
feat/factory-extraction
venture/methaneproof/dit-adapter
venture/fieldproof/biologicals-demo
venture/aglend/lender-profile
venture/supplierevidence/scope3-profile
sync/upstream-2026-09-06
```

Do not maintain permanent product branches such as `methaneproof`, `fieldproof`, `aglend`, and `supplierevidence`. That would create drifting copies of the Rails app, schemas, verifier, SDKs, and migrations.

## Canonical App Tree

The Rails application lives in `apps/console/`.

Foundry generation and extraction should treat `apps/console/` as the only canonical app tree. Root-level `app/` and `db/` paths are noncanonical unless explicitly introduced for a generated standalone output.
