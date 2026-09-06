# Branding

Foundry companies are independent brands, not product modules.

AgEvidence should usually be absent from the customer-facing hero and primary logo. It should be visible in technical architecture, developer docs, trust/provenance pages, investor architecture, API metadata, verifier output, and customer artifacts as protocol provenance.

Each company separates:

- brand: ownable company identity
- category descriptor: what the institution should understand it is
- GTM proposition: why the first buyer should care now

The naming scorecard lives in `ventures/<venture>/brand/naming.yml` and is executable. Each score must cite `evidence_refs` from the same source/proof-point ledger used by GTM.

```sh
bin/factory brand score methaneproof
```

The required tests are buyer recognition, role discipline, land-motion fit, expansion permission, and investor signal.
