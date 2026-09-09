# Start Here

AgEvidenceFoundry is a thin factory fork for evidence-native agriculture companies.

AgEvidence owns the evidence substrate. Foundry owns company formation. Individual companies own their vertical differentiation.

The fastest path is:

1. Sync the fork with upstream AgEvidence using `bin/sync-upstream`.
2. List executable packs with `bin/factory list`.
3. Validate the packs with `bin/factory doctor`.
4. Inspect commercial readiness with `bin/factory doctor methaneproof --verbose`.
5. Score accounts with `bin/factory gtm score methaneproof`.
6. Run a vertical with `bin/factory demo methaneproof`.
7. Study [FACTORY.md](../FACTORY.md), [STARTUP_MAP.md](STARTUP_MAP.md), and [docs/factory/task-tree.md](factory/task-tree.md).

## What You Are Looking At

The Rails console is not just a repository admin app. It is a complete reference evidence business:

- projects define commercial evidence cases
- source records preserve custody and identity
- evidence records normalize supplied material
- gaps turn missing evidence into a product surface
- evaluations run requirements against accepted evidence
- review keeps human judgment explicit
- determinations bound what can responsibly be claimed
- artifacts package evidence for external use
- bundles let customers leave with their evidence
- reliance events record downstream economic use
- verification lets recipients check an artifact without trusting the app UI
- ProgramProfiles encode market and program rules
- developer keys, schemas, OpenAPI, logs, and webhooks expose the infrastructure

## The Founder Move

Keep the evidence layer. Change the company around it.

Do not differentiate on basic provenance, evidence identity, artifact structure, portable bundles, or verification contracts when shared infrastructure creates a larger ecosystem.

Differentiate on distribution, workflow, proprietary data access, algorithms, domain interpretation, integrations, customer experience, and market-specific execution.

## First Commands

```sh
bin/sync-upstream
bin/factory list
bin/factory doctor
bin/factory doctor methaneproof --verbose
bin/factory brand score methaneproof
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
bin/factory validation show methaneproof
bin/factory validation pricing methaneproof
bin/factory validation gate methaneproof
bin/factory claims check methaneproof
bin/factory research stale methaneproof
bin/factory pitch customer methaneproof
bin/factory demo methaneproof
bin/doctor
```

Open `http://127.0.0.1:3000`.

Demo login:

- Email: `demo`
- Password: `demo`

## Next Documents

- [STARTUP_MAP.md](STARTUP_MAP.md)
- [../FACTORY.md](../FACTORY.md)
- [factory/task-tree.md](factory/task-tree.md)
- [venture-playbooks/methaneproof.md](venture-playbooks/methaneproof.md)
- [venture-playbooks/fieldproof.md](venture-playbooks/fieldproof.md)
- [venture-playbooks/aglend.md](venture-playbooks/aglend.md)
- [venture-playbooks/supplierevidence.md](venture-playbooks/supplierevidence.md)
- [startup-recipes/README.md](startup-recipes/README.md)
- [screenshots/README.md](screenshots/README.md)
- [../apps/console/README.md](../apps/console/README.md)
