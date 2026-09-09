# Startup Map

Use this table to decide what to steal from AgEvidence and what to make your own.

In Foundry, the executable boundary is:

```text
Generic / trust infrastructure -> upstream AgEvidence
Factory-specific machinery -> AgEvidenceFoundry
Vertical operating thesis -> ventures/<venture>
Reusable cross-vertical IP -> parent
Truly vertical proprietary advantage -> allocated by formation_architecture
Customer, data, and improvement rights -> allocated venture by venture
```

| Layer | Reuse unchanged | Configure | Replace |
| --- | --- | --- | --- |
| Canonical evidence primitives | yes | no | no |
| Verification contracts | yes | no | no |
| Bundle format | yes | no | no |
| Provenance rules | yes | no | no |
| Organization model | yes | no | no |
| API authentication | yes | no | no |
| ProgramProfiles | no | yes | no |
| Requirements | no | yes | no |
| Evidence vocabulary | no | yes | no |
| UI terminology | no | yes | no |
| Buyer workflow | no | yes | no |
| Vertical integrations | no | no | yes |
| Pricing | no | no | yes |
| Customer-facing brand | no | no | yes |
| Proprietary analytics | no | no | yes |
| Domain-specific models | no | no | yes |

## Reuse

Reuse the evidence substrate when compatibility creates more value than uniqueness:

- evidence identities
- source record custody
- project boundaries
- evaluation lifecycle
- determination lifecycle
- artifact structure
- verifier-result contract
- reliance records
- API authentication model

## Configure

Configure the market layer:

- ProgramProfiles
- requirements
- evidence classes
- accepted evidence types
- evaluation modes
- limitation templates
- jurisdiction labels
- buyer and reviewer vocabulary

## Replace

Replace or allocate the company-specific layer:

- brand
- positioning
- pricing
- customer workflow
- domain integrations
- proprietary models
- onboarding
- commercial analytics
- sales motion

Whether those assets move to an independent NewCo, stay parent-owned under a field license, sit inside a controlled subsidiary, or remain an internal product line is a Company Pack architecture decision. The compatibility field `company.independence_model` may still say `standalone_spinout`; the active architecture hypothesis lives in `formation_architecture`.

## White-Label Checklist

To make the Rails console feel like your company, change:

- company name, logo, and support identity
- ProgramProfiles and requirements
- jurisdiction and market vocabulary
- source system integrations
- evidence classes and terminology
- email templates and customer workflow
- pricing and packaging

Keep:

- evidence identities
- provenance and custody records
- project boundaries
- evaluation, review, and determination lifecycle
- artifact manifests and bundles
- verification and reliance records
