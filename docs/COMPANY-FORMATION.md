# Company Formation

AgEvidenceFoundry is a company operating system.

A founder should inherit five things at once:

- product substrate: evidence model, requirements, workflows, artifacts, verifier, reliance event
- commercial substrate: ICP, accounts, triggers, pricing, offers, discovery, outbound
- company identity: brand, category, language, claim discipline, visual DNA, pitch
- research memory: sources, hypotheses, evidence classes, decisions
- formation state: gates, experiments, milestones, founder status

The source of truth is structured YAML under `ventures/<venture>/`. Decks, PDFs, websites, and one-pagers are compiled artifacts.

## Pack Layout

```text
ventures/<venture>/
  company.yml
  product/
  brand/
  pitch/
  gtm/
  accounts/
  research/
  formation/
  demos/
  tests/
  generated/
```

The technical product layer remains a Venture Pack under `product/`. The Company Pack wraps it with commercial and formation machinery.

## Commands

```sh
bin/factory doctor methaneproof --verbose
bin/factory brand score methaneproof
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory research stale methaneproof
```
