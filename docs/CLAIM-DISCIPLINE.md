# Claim Discipline

Every company must define allowed, qualified, and prohibited language.

The claim-discipline file lives at:

```text
ventures/<venture>/brand/claim_discipline.yml
```

Run:

```sh
bin/factory claims check methaneproof
```

By default, the command scans the venture's generated artifacts. Pass explicit paths to check draft copy before it is generated.

The goal is to prevent companies from implying regulated roles they do not perform: certification, underwriting, audit, insurance, registry, government approval, or guaranteed outcomes.
