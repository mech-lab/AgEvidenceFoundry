# GTM

Foundry sells to reliance events, not generic data ownership.

Each company keeps GTM source files under `ventures/<venture>/gtm/` and account-specific interpretation under `ventures/<venture>/accounts/`.

Tier-1 accounts must have a source-backed commercial trigger. Use `event_date` for the forcing-function date and `observed_at` for the date the Foundry recorded or reviewed the trigger. Without that distinction, a target is a market-map entry, not a sales opportunity.

Useful commands:

```sh
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
```

Scores are prioritization heuristics. Each score component must cite evidence so the account list does not drift into unsupported narrative.
