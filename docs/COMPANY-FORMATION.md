# Company Formation

AgEvidenceFoundry is a company operating system.

A founder should inherit six things at once:

- product substrate: evidence model, requirements, workflows, artifacts, verifier, reliance event
- commercial substrate: ICP, accounts, triggers, pricing, offers, discovery, outbound
- company identity: brand, category, language, claim discipline, visual DNA, pitch
- research memory: sources, hypotheses, evidence classes, decisions
- formation state: gates, experiments, milestones, founder status
- formation architecture: provisional corporate boundary, founder contribution, customer rights, IP allocation, extraction mode

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

## Formation Architecture

Every Company Pack keeps `company.independence_model` for compatibility, but the live architecture hypothesis is `formation_architecture`.

The architecture remains provisional until external reliance creates enough evidence to review property rights. That review should decide whether the venture becomes an independent NewCo, licensed NewCo, thin operating company, controlled subsidiary, or internal product line.

The architecture file should allocate:

- trust layer ownership
- application IP
- integrations
- customer architecture
- data rights
- improvement obligations
- founder contribution
- parent economics
- extraction or retention mode

## Commands

```sh
bin/factory doctor methaneproof --verbose
bin/factory brand score methaneproof
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory research stale methaneproof
```
