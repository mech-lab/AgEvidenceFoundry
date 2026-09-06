# GTM

Foundry sells to reliance events, not generic data ownership.

Each company keeps GTM source files under `ventures/<venture>/gtm/` and account-specific interpretation under `ventures/<venture>/accounts/`.

Tier-1 accounts must have a dated commercial trigger with a source. Without a dated trigger, a target is a market-map entry, not a sales opportunity.

Useful commands:

```sh
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
```

Scores are prioritization heuristics. Each score component must cite evidence so the account list does not drift into unsupported narrative.
