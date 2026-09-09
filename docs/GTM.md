# GTM

Foundry sells to reliance events, not generic data ownership.

Each company keeps GTM source files under `ventures/<venture>/gtm/` and account-specific interpretation under `ventures/<venture>/accounts/`.

Tier-1 accounts must have a source-backed commercial trigger. Use `event_date` for the forcing-function date and `observed_at` for the date the Foundry recorded or reviewed the trigger. Without that distinction, a target is a market-map entry, not a sales opportunity.

Useful commands:

```sh
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
bin/factory validation show methaneproof
bin/factory validation pricing methaneproof
bin/factory validation gate methaneproof
```

Scores are prioritization heuristics. Each score component must cite evidence so the account list does not drift into unsupported narrative.

## Phase 0 Pricing

Pricing is validated during Phase 0, alongside problem, reliance, buyer, and artifact fit. `gtm/validation/pricing/hypothesis.yml` contains the speculative price range and value metrics under test. `gtm/validation/pricing/synthesis.yml` records evidence from interviews and price tests. `gtm/pricing.yml` is the current policy derived from that evidence trail, not the place where the first guess lives.

The pricing evidence ladder is `P0` speculation, `P1` verbal tolerance, `P2` budget mechanics identified, `P3` concrete price reaction, `P4` commercial advancement, and `P5` money.
