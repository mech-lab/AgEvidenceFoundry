# AgEvidence Foundry

Build evidence-native agricultural companies faster.

AgEvidence Foundry is a company-formation substrate for founders building businesses whose agricultural claims, decisions, or records must eventually be relied upon by another institution.

Bring:

- domain expertise
- a buyer hypothesis
- an evidence problem
- a consequential reliance event

The Foundry supplies reusable infrastructure for:

- evidence provenance
- schemas and typed evidence
- requirements and ProgramProfiles
- evaluation
- review
- determinations
- portable artifacts
- verification
- APIs and SDKs
- company configuration
- branding
- category definition
- customer and investor pitching
- account research
- GTM scoring
- discovery
- pricing and first offers
- formation experiments
- architecture-aware extraction or retention

The objective is not to create ten modules of AgEvidence. The objective is to repeatedly validate evidence-native companies or product lines that share an interoperable evidence grammar while choosing the right corporate boundary for each venture.

```text
Domain + buyer + reliance hypothesis
        |
        v
Company Pack -> paid pilot -> external reliance -> architecture decision
                                                |
                                                v
             independent | licensed | thin NewCo | subsidiary | internal
```

## The Thesis

Most founders building evidence-sensitive agricultural software should not spend their first 12 to 18 months rebuilding provenance, evidence identity, requirements engines, review workflows, artifacts, verification contracts, API infrastructure, and audit histories.

Those are shared infrastructure.

A founder should spend that time discovering:

1. who has the consequential decision
2. what evidence they need
3. who will pay to make that evidence usable
4. what workflow is unique to the market
5. what proprietary advantage the company can accumulate

AgEvidence provides the shared evidence substrate. AgEvidence Foundry adds the repeatable company-formation machinery around it.

> AgEvidence is why the evidence is interoperable. The startup is why the buyer cares.

## The Factory

```text
                         DOMAIN FOUNDER
                              |
                domain + buyer + hypothesis
                              |
                              v
                    AGEVIDENCE FOUNDRY
                              |
        +---------------------+---------------------+
        |                     |                     |
        v                     v                     v
 TRUST SUBSTRATE       COMPANY SUBSTRATE      COMMERCIAL SUBSTRATE
        |                     |                     |
 provenance                 brand                  ICP
 evidence                   category               accounts
 requirements               vocabulary             triggers
 evaluation                 pitch                  offers
 review                     visual system          pricing
 artifacts                  claim discipline       discovery
 verification               founder story          objections
 reliance                   investor story         relationships
        |                     |                     |
        +---------------------+---------------------+
                              |
                              v
                      VERTICAL COMPANY
                              |
                        design partner
                              |
                              v
                           PAID PILOT
                              |
                              v
                      ISSUED ARTIFACT
                              |
                              v
                    EXTERNAL RELIANCE
                              |
                              v
                   ARCHITECTURE DECISION
                              |
                              v
            independent | licensed | thin NewCo | subsidiary | internal
```

External reliance is the unifying graduation test. Corporate architecture is not universal.

A venture does not graduate because the app boots. It graduates when a real external institution is prepared to use the evidence. After that, Foundry decides whether the validated opportunity should become an independent company, a licensed NewCo, a thin operating company on parent IP, a controlled subsidiary, or an internal AgEvidence product line.

## What Comes Out

A formed company should leave with more than source code.

### Product

- working vertical application
- ProgramProfiles
- requirements
- domain vocabulary
- evidence mappings
- integrations
- artifact definitions
- verifier-compatible outputs

### Brand

- corporate identity
- category descriptor
- first-wedge proposition
- product vocabulary
- visual direction
- AgEvidence endorsement rules
- prohibited-claims boundaries

### Commercial

- ideal-customer profile
- target-account universe
- buyer-role map
- account scoring
- live commercial triggers
- pricing hypothesis
- first paid offer
- discovery playbook
- objection handling
- relationship graph

### Pitch

- customer story
- investor story
- founder-recruitment story
- architecture story
- proof-point ledger

### Formation

- founder hypothesis
- experiments
- decision log
- milestone gates
- reliance target
- provisional formation architecture
- architecture decision and execution state

## Ownership Boundaries

The Foundry only works if the boundaries stay clean.

### AgEvidence Owns The Shared Trust Grammar

Examples:

- SourceRecord
- Observation
- SpatialObservation
- InterventionEvent
- OperationalEvent
- ModelRun
- canonicalization
- artifact contracts
- verification contracts
- bundle formats
- reliance records
- SDK interfaces
- conformance fixtures

If a capability should work identically for every evidence-native company, it probably belongs upstream in AgEvidence.

### Foundry Owns Company-Formation Machinery

Examples:

- Company Pack schemas
- venture generators
- brand schemas
- GTM schemas
- account research structures
- pitch generators
- formation gates
- cross-portfolio relationship intelligence
- extraction tooling

### Company Packs Own Vertical Configuration

Examples:

- underwriting requirements
- methane intervention requirements
- supplier acceptance profiles
- field-trial claim semantics
- company terminology
- first offers
- account interpretations
- vertical demo scenarios

### Architecture Allocates Proprietary Advantage

Examples:

- customer relationships
- proprietary integrations
- algorithms
- unique datasets
- pricing
- private workflows
- distribution
- proprietary analytics
- internal commercial data

Generic and reusable IP defaults upstream or to the parent. Truly vertical proprietary advantage is allocated by the Company Pack architecture. Independent spinout is one possible outcome, not the universal endpoint.

Memorize the rule:

```text
Generic / trust infrastructure                  -> AgEvidence
Reusable formation machinery                    -> Foundry
Vertical operating thesis                       -> Company Pack
Reusable cross-vertical IP, integrations, data  -> presumptively Parent
Truly vertical proprietary advantage            -> allocated by Company Pack architecture
Customer / data / improvement rights            -> allocated venture by venture
External reliance                               -> graduation test
Independent spinout                             -> one possible graduation architecture
```

## Repository Map

```text
AgEvidenceFoundry/
|
├── protocol/                 shared AgEvidence trust contracts
├── packages/                 SDKs and verifier implementations
├── apps/console/             reference evidence application
|
├── factory/                  company-formation machinery
│   ├── schemas/
│   ├── generators/
│   ├── loaders/
│   ├── templates/
│   └── conformance/
|
├── commercial/               shared commercial intelligence
│   ├── schemas/
│   ├── graph/
│   ├── scoring/
│   ├── templates/
│   └── vocabulary/
|
├── ventures/                 executable Company Packs
│   ├── methaneproof/
│   ├── fieldproof/
│   ├── aglend/
│   └── supplierevidence/
|
├── docs/                     methodology and reference documentation
├── research/                 reproducible scientific/research work
├── generated/                disposable compiled artifacts
|
└── bin/
    ├── doctor
    ├── demo
    ├── factory
    └── sync-upstream
```

Mental model:

> `protocol/` describes what evidence means.
> `factory/` describes how companies are formed.
> `commercial/` describes reusable market intelligence.
> `ventures/` describes how each company differs.

## Operating Commands

| Goal | Command | Status |
| --- | --- | --- |
| Check repository | `bin/doctor` | implemented |
| Run reference business | `bin/demo` | implemented |
| List companies | `bin/factory list` | implemented |
| Inspect company | `bin/factory show methaneproof` | implemented |
| Validate company | `bin/factory doctor methaneproof` | implemented |
| Inspect readiness | `bin/factory doctor methaneproof --verbose` | implemented |
| Run company demo | `bin/factory demo methaneproof` | partial |
| Run venture tests | `bin/factory test methaneproof` | partial |
| Score brand | `bin/factory brand score methaneproof` | implemented |
| Check generated claims | `bin/factory claims check methaneproof` | implemented |
| Validate GTM | `bin/factory gtm validate methaneproof` | implemented |
| Score accounts | `bin/factory gtm score methaneproof` | implemented |
| Render opportunity hypothesis | `bin/factory gtm hypothesis methaneproof sea_forest` | implemented |
| Inspect Phase 0 validation | `bin/factory validation show methaneproof` | implemented |
| Inspect pricing validation | `bin/factory validation pricing methaneproof` | implemented |
| Inspect Phase 0 gate | `bin/factory validation gate methaneproof` | implemented |
| Check stale research | `bin/factory research stale methaneproof` | implemented |
| Render customer pitch | `bin/factory pitch customer methaneproof` | implemented |
| Render investor pitch | `bin/factory pitch investor methaneproof` | implemented |
| Render founder pitch | `bin/factory pitch founder methaneproof` | implemented |
| Create company | `bin/factory new <name>` | planned |
| Render website copy | `bin/factory render website <name>` | planned |
| Extract company architecture | `bin/factory extract <name> --architecture licensed-newco <path>` | planned |
| Retain internal architecture | `bin/factory retain <name> --architecture internal-product` | planned |
| Sync upstream | `bin/sync-upstream` | implemented |

`partial` means the command exists and carries the active pack, but the full end-to-end venture-specific workflow is still being built.

## The Company Pack

Every incubating company is represented as a Company Pack.

A Company Pack is the declarative definition of an evidence-native company. It is not merely deployment configuration. It is the company's current operating thesis expressed in a form that software, commercial research, branding, collateral generation, and formation tooling can all consume.

```text
ventures/<company>/
|
├── company.yml
|
├── product/
│   ├── venture.yml
│   ├── terminology.yml
│   ├── features.yml
│   ├── reliance.yml
│   ├── program_profiles/
│   ├── requirements/
│   ├── artifact_templates/
│   └── integrations/
|
├── brand/
│   ├── brand.yml
│   ├── naming.yml
│   ├── vocabulary.yml
│   ├── claim_discipline.yml
│   ├── visual.yml
│   └── assets/
|
├── pitch/
├── gtm/
├── accounts/
├── research/
├── formation/
├── demos/
├── tests/
└── generated/
```

Abbreviated example:

```yaml
id: methaneproof
company:
  working_name: MethaneProof
  status: formation
  independence_model: standalone_spinout
formation_architecture:
  status: provisional
  current_hypothesis: licensed_independent_newco
  confidence: low
  binding: false
  decision_gate: F9A
  architecture_code: N3
  candidate_architectures:
    - N2
    - N3
    - N5
  trust_layer:
    ownership: agevidence
    access: open_neutral_verifier
  application_ip:
    ownership: parent
    newco_rights: exclusive_field_license
  customer_architecture:
    model: layered
  founder_contribution:
    technical_creation: low
    domain_ip_creation: medium
    customer_creation: high
    capital_formation: high
    operating_execution: high
  decision:
    gate: F9A
    locked_at: null
    rationale: null
category:
  descriptor: Neutral methane intervention evidence infrastructure
buyer:
  initial:
    type: methane_technology_provider
reliance:
  event: methane_claim_acceptance
  artifact: methane_evidence_statement
land_motion:
  scope: One intervention, one production environment, one downstream reliance workflow.
agevidence:
  protocol_required: true
  endorsement: technical_only
```

The product pack under `product/` remains the technical vertical definition. The root `company.yml` and neighboring folders turn that vertical product into a company formation object.

The `id` is permanent infrastructure identity. It names directories, CLI targets, tests, generated paths, and extraction boundaries. The `company.working_name` is mutable brand strategy and may change as naming tests, buyer language, or trademark work improves. For example, `supplierevidence` can remain the stable venture ID while `SourceRelay` is the current buyer-facing working name.

## Branding

Branding is part of the Company Pack.

Every company is expected to have three separate language layers:

1. Brand: who are you?
2. Category descriptor: what are you?
3. GTM proposition: why should the first buyer care now?

Do not make the corporate name explain the entire architecture.

Example:

```text
MethaneProof
Brand

Neutral methane intervention evidence infrastructure
Category

Turn fragmented intervention evidence into something your downstream buyer can inspect.
First-wedge GTM proposition
```

### Five Naming Tests

Every proposed brand must pass five tests:

1. Buyer recognition: does the first buyer recognize the workflow?
2. Role discipline: does the name avoid implying that the company is itself the lender, auditor, insurer, verifier, certifier, registry, or regulator?
3. Land-motion fit: does the name make the first narrowly scoped engagement easier to sell?
4. Expansion permission: can the name survive beyond the initial ANZ wedge?
5. Investor signal: does it sound like repeatable infrastructure or software rather than project consulting?

Run:

```sh
bin/factory brand score methaneproof
```

The scorecard lives at `ventures/<company>/brand/naming.yml`. It should retain the decision history, not only the final name.

## Independent Brands, Shared Protocol

Companies formed here are not intended to look like:

- AgEvidence Methane
- AgEvidence Finance
- AgEvidence Scope 3
- AgEvidence Claims

They should become independent customer-facing brands. AgEvidence attribution becomes more visible as the conversation becomes more technical.

| Surface | AgEvidence treatment |
| --- | --- |
| Homepage hero | generally absent |
| Main company logo | absent |
| Sales-deck cover | usually absent |
| Technical architecture | visible |
| Developer documentation | prominent |
| Trust/provenance page | prominent |
| Investor architecture | prominent |
| Foundry recruitment | very prominent |
| API metadata | protocol/version reference |
| Issued artifacts | protocol/version reference |

The company is the buyer-facing object. AgEvidence is the trust and interoperability layer.

## GTM Is Not An Appendix

A Company Pack is not ready merely because the app boots.

Every company must define:

- the relying institution
- the decision being made
- the evidence problem
- the economic buyer
- the first paid offer
- the commercial trigger
- the smallest workflow capable of producing external reliance

Portfolio rule:

> Sell to the reliance event, not merely to the data owner.

Run:

```sh
bin/factory gtm validate methaneproof
bin/factory gtm score methaneproof
bin/factory gtm hypothesis methaneproof sea_forest
bin/factory validation show methaneproof
bin/factory validation pricing methaneproof
bin/factory validation gate methaneproof
```

## Phase 0 Validates The Economic System

Phase 0 is customer and commercial validation. It validates five things at once:

1. Problem: is this painful and recurrent?
2. Reliance: does a consequential external decision depend on it?
3. Buyer: who owns the problem and budget?
4. Product/artifact: what output would enter the real workflow?
5. Pricing: what buying unit, budget source, entry price, and expansion model can support a company?

The Phase 0 validation tree lives at:

```text
ventures/<venture>/gtm/validation/
├── hypothesis.yml
├── actor_map.yml
├── problem/
│   ├── interview_plan.yml
│   └── signals.yml
├── pricing/
│   ├── hypothesis.yml
│   ├── interview_guide.yml
│   ├── tests.yml
│   ├── observations.yml
│   └── synthesis.yml
├── interviews/
├── artifact_tests.yml
├── synthesis.yml
└── gate.yml
```

Pricing assumptions start in `gtm/validation/pricing/hypothesis.yml`, interview evidence accumulates in the validation tree, and `gtm/pricing.yml` is the current commercial pricing policy produced from that evidence. Before evidence exists, `gtm/pricing.yml` must be explicit that the policy is still `phase_zero_unvalidated`.

Pricing evidence uses a ladder:

- `P0`: speculation.
- `P1`: verbal tolerance.
- `P2`: budget mechanics identified.
- `P3`: concrete price/scope reaction.
- `P4`: commercial advancement.
- `P5`: money.

Phase 0 should not leave `ITERATE` until pricing has at least budget mechanics from multiple organizations and one strong buying-process signal.

## Accounts Are Structured Data

The Foundry uses one base account grammar across companies while preserving venture-specific commercial interpretations.

Every target should eventually contain:

- organization
- legal or trading name
- geography
- ownership
- financing context
- relevant business unit
- venture-specific role
- priority tier
- dated trigger
- economic buyer
- champion
- technical user
- blocker
- evidence-producing systems
- current evidence problem
- first offer
- expansion path
- partner graph
- next best action
- source ledger
- confidence grade

### Shared Contact-Role Vocabulary

| Code | Role | Meaning |
| --- | --- | --- |
| EB | Economic Buyer | Controls or can sponsor budget |
| CH | Champion | Owns the operational pain |
| TU | Technical User | Evaluates or operates the workflow |
| EX | Executive Sponsor | Provides strategic air cover |
| IN | Influencer | Shapes policy, channel, or procurement |
| BL | Blocker | Legal, security, assurance, architecture, procurement, or model risk |
| PA | Partner / Alliance | Routes evidence or distribution |
| EV | Evidence Producer | Produces source data but may not pay |

Shared vocabulary lives in `commercial/vocabulary/contact_roles.yml`.

## A Logo Is Not An Opportunity

Every Tier-1 sales opportunity requires a source-backed commercial trigger with two dates:

- `event_date`: when the commercial forcing function happened or became active.
- `observed_at`: when the Foundry recorded or reviewed that trigger.

Examples:

- financing
- regulatory deadline
- product launch
- grant
- field trial
- distribution agreement
- supplier program
- reporting requirement
- leadership change
- commercial partnership

A company with no live trigger belongs in the market map, not the active pipeline. If only an internal dossier is available, the trigger can remain dossier-backed, but the account should not pretend that dossier creation is the same thing as the commercial event date.

`bin/factory gtm validate <company>` enforces this rule for Tier-1 accounts.

## Opportunity Hypothesis

Every active account should be reducible to:

```text
Because [organization] is currently running [specific program/event],
it must establish or review [specific evidence].
[company] can provide [specific artifact/workflow],
initially sold to [buyer/team] around [live decision].
```

Render one:

```sh
bin/factory gtm hypothesis methaneproof sea_forest
```

This keeps outbound focused on a live decision, not a generic description of the product.

## Commercial Evidence Discipline

A Foundry company should not treat market research as untyped notes.

Commercial statements should carry:

- source
- date observed
- confidence
- fact or inference classification
- owner when known
- refresh date

Evidence classes:

- `verified_public_signal`
- `brief_derived`
- `supplied_research`
- `gtm_inference`

GTM inferences guide discovery. They must not be represented externally as verified facts.

Example external-use statement:

```yaml
statement:
  text: Buyer operates a supplier evidence program.
classification: verified_public_signal
source: src_0042
checked_at: 2026-09-06
refresh_after_days: 90
external_use: true
```

Example discovery-only hypothesis:

```yaml
statement:
  text: Sustainability team probably reconstructs farm evidence manually.
classification: gtm_inference
source: src_0042
external_use: false
```

Run:

```sh
bin/factory research stale methaneproof
```

This is AgEvidence discipline applied to company building.

## Share Intelligence, Allocate Customer Ownership Deliberately

The same institution may participate in several evidence chains.

For example, a processor could be:

- a reliance endpoint for MethaneProof
- a customer or evidence aggregator for SupplierEvidence
- an acceptance node for FieldProof
- an evidence source relevant to AgLend

Therefore:

1. organizations and people can be shared Foundry records
2. venture-specific roles remain separate
3. one executive account owner coordinates first touch
4. customer ownership is selected by venture architecture
5. evidence compatibility does not imply that every NewCo should own a separate copy of the relationship

Shared relationship structures live in `commercial/graph/`.

Customer architecture is a Company Pack decision:

```yaml
customer_architecture:
  model: layered
  parent:
    owns:
      - master_platform_agreement
      - technical_integration
  newco:
    owns:
      - vertical_sow
      - domain_relationship
```

Use `newco_owned` when a venture-specific relationship is the company. Use `layered` when the parent should retain the platform account and the NewCo should own the vertical statement of work. Use `parent_network` when institutional graph ownership is the strategic asset.

## Formation Architecture

Every current cohort pack still retains the compatibility field:

```yaml
company:
  independence_model: standalone_spinout
```

That field is no longer doctrine. The active source of truth is `formation_architecture`, which makes property-right allocation part of the Company Pack beside buyer, reliance event, brand, pricing, and founder research.

External reliance proves whether there is a company. It does not automatically decide where the assets should live.

Architecture options are selected per venture:

| Code | NewCo-specific outcome |
| --- | --- |
| N1 | Open commons / independent spinout |
| N2 | Open core / independent NewCo |
| N3 | Open protocol / parent-owned vertical IP |
| N4 | Open verifier / parent platform |
| N5 | Open verifier / parent-owned application |
| N6 | Open verifier / parent-owned network |
| N7 | Controlled venture group |
| N8 | Integrated AgEvidence business unit |
| N9 | Open standard / integrated parent |
| N10 | Fully proprietary integrated product |

The first cohort should test architecture hypotheses as well as venture hypotheses:

| Venture | Current hypothesis | Candidate range | What it tests |
| --- | --- | --- | --- |
| MethaneProof | `licensed_independent_newco` | N2, N3, N5 | Can an external founder build a financeable methane vertical around parent technology? |
| FieldProof | `parent_platform_thin_newco` | N3, N4, N6 | Can one parent technical estate support specialized independent GTM? |
| AgLend | `parent_network_operating_vertical` | N4, N6, N8 | Does institutional account ownership compound across workflows? |
| SupplierEvidence / SourceRelay | `parent_network_or_integrated_product` | N5, N6, N8 | Are network effects valuable enough that full spinout independence is counterproductive? |

Architecture remains provisional before evidence. A founder candidate still needs to know the current hypothesis, alternatives, confidence, and whether the decision is binding:

```yaml
formation_architecture:
  status: provisional
  current_hypothesis: licensed_independent_newco
  confidence: low
  binding: false
  decision_gate: F9A
```

The decision should consider founder contribution:

```yaml
founder_contribution:
  technical_creation: low
  domain_ip_creation: medium
  customer_creation: high
  capital_formation: high
  operating_execution: high
```

If the founder creates most of the company, more independence is rational. If Foundry has already created product, IP, and initial customers, greater parent ownership is rational. If the founder contributes critical proprietary domain IP, a joint or independently owned structure becomes more compelling.

IP allocation follows a reuse test:

```text
Could another AgEvidence venture plausibly reuse this?
YES -> presumptively parent
NO  -> candidate NewCo asset

Does the vertical require exclusivity for financing?
YES -> exclusive field license may be sufficient
NO  -> retain centrally
```

## Initial Foundry Cohort

The current 3+1 cohort exists to test whether the same evidence grammar can support materially different companies and different corporate architectures.

```text
                    AgEvidence
                        |
        +---------------+----------------+
        v               v                v
  MethaneProof      FieldProof         AgLend
       |                |                |
       +---------- SupplierEvidence ----+
                        |
                        v
               reusable evidence economy
```

### MethaneProof

Question: did the claimed methane intervention occur, and can the resulting evidence survive downstream reliance?

Proves: fast vertical specialization.

### FieldProof

Question: can an agricultural technology company turn trials, telemetry, and models into a bounded commercial claim another institution can inspect?

Proves: broad reuse across funded agtech companies.

### AgLend

Question: can agricultural operating evidence become usable inside institutional financial decision workflows?

Proves: financial-grade reliance.

### SupplierEvidence

Question: can evidence produced across fragmented agricultural suppliers move downstream into enterprise reporting and assurance?

Proves: networked evidence reuse and time-sensitive enterprise GTM.

The stable pack id is `supplierevidence`; the current customer-facing brand file uses `SourceRelay`.

## Founder Research

Founder research is part of the Company Pack, not a separate recruiting note. Each venture keeps the current founder hypothesis in `ventures/<company>/formation/founder.yml` and the founder-facing narrative in `ventures/<company>/pitch/founder.yml`.

The formation file answers who is still missing from the company. The pitch file answers why that person should care, what Foundry removes from the starting burden, and what formation risk they must own.

Current cohort founder hypotheses:

| Venture | Status | Desired founder profile | Founder job | Formation risk |
| --- | --- | --- | --- | --- |
| MethaneProof | `candidate_needed` | methane intervention commercialization, livestock systems, processor relationships | Own methane buyer relationships, intervention semantics, delivery integrations, and the commercial wedge. | Avoid implying certification, registry authority, or guaranteed reductions. |
| FieldProof | `candidate_needed` | agtech commercialization, trial evidence, distributor or buyer relationships | Own buyer language, the first claim family, agronomic evidence semantics, and commercial relationships. | Avoid sounding like a warranty, trial operator, or certifier. |
| AgLend | `candidate_needed` | agribusiness finance, bank risk workflows, agricultural data integration | Own lender access, credit workflow empathy, buyer language, and the first product wedge. | Avoid implying farm grading, borrower scoring, loan approval, or lender activity. |
| SupplierEvidence / SourceRelay | `candidate_needed` | corporate sustainability, supplier programs, assurance or reporting workflows | Own buyer requirements, supplier workflows, assurance language, and the first reporting wedge. | Avoid sounding like an assurance firm, carbon calculator, or ESG reporting dashboard. |

Founder research should change as discovery changes. When buyer interviews alter the reliance event, first paid offer, category language, evidence boundary, or founder contribution profile, update the founder profile and founder pitch alongside the GTM, formation, and architecture files.

## Founder Workflow

### Step 1 - Define The Reliance Event

Do not start with features.

Answer:

- Who eventually relies on the output?
- What decision are they making?
- What evidence must survive that decision?
- What artifact could travel into their workflow?

### Step 2 - Define The First Buyer

The evidence producer, buyer, and relying institution may be different.

Identify:

- first payer
- economic buyer
- operational champion
- technical user
- blocker
- downstream relying party

### Step 3 - Create The Company Pack

Planned:

```sh
bin/factory new <company>
```

Today, use the current packs under `ventures/` as examples.

### Step 4 - Configure The Vertical

Define:

- ProgramProfiles
- requirements
- vocabulary
- accepted evidence
- artifact type
- vertical integrations

### Step 5 - Configure Company Identity

Define:

- brand candidates
- category descriptor
- GTM proposition
- role boundaries
- product vocabulary
- visual direction

### Step 6 - Build The Target Universe

Identify accounts and score them.

No Tier-1 account without a dated commercial trigger.

### Step 7 - Define The First Paid Offer

The smallest offer should attempt to complete one real reliance workflow.

### Step 8 - Run Discovery

Customer discovery should be allowed to change:

- requirements
- ProgramProfiles
- positioning
- terminology
- offer
- pricing
- account score
- company name

### Step 9 - Issue An Artifact

A successful pilot should produce something portable and inspectable.

### Step 10 - Record External Reliance

The goal is not a demo. The goal is a real external institution prepared to use the evidence.

### Step 11 - Review Property Rights And Architecture

External reliance should trigger a deliberate review of:

- reusable parent IP
- truly vertical IP
- customer ownership
- data rights
- improvement obligations
- founder contribution
- financing requirements

### Step 12 - Execute The Chosen Structure

Planned:

```sh
bin/factory extract <company> --architecture licensed-newco ../CompanyName
bin/factory retain <company> --architecture internal-product
```

The venture becomes an independent company, licensed NewCo, thin operating company, controlled subsidiary, or retained product line according to `formation_architecture`.

## Formation Gates

```text
F0  company thesis
 |
 v
F1  reliance event defined
 |
 v
F2  founder hypothesis
 |
 v
F3  buyer/workflow hypothesis
 |
 v
F4  brand/category/proposition tested
 |
 v
F5  qualified target universe
 |
 v
F6  design partner
 |
 v
F7  paid pilot
 |
 v
F8  artifact issued
 |
 v
F9  external reliance
 |
 v
F9A property-rights / architecture review
 |
 v
F10 chosen structure executed
```

A venture does not graduate because the application is technically complete. It graduates when a real relying party validates the workflow strongly enough to justify choosing and executing the right corporate structure.

Formation state lives in `ventures/<company>/formation/status.yml`. Architecture state lives in `ventures/<company>/company.yml` under `formation_architecture`.

## Foundry Metrics

The primary Foundry KPI is Time to First Reliance (TTFR): time from formation hypothesis to the first external institutional reliance event.

Supporting metrics:

- Time to Vertical Demo
- Time to Credible Brand
- Time to Qualified Target Universe
- Time to First Buyer Conversation
- Time to Design Partner
- Time to Paid Pilot
- Time to First Artifact
- Time to First Verification
- Time to First Reliance
- shared-code ratio
- Foundry-generated versus company-specific LOC

If each cohort requires less generic engineering, less generic GTM design, less brand invention, and less company setup work than the cohort before it, the Foundry is working.

## Feedback Loop

```text
BUYER RESEARCH
      |
      v
COMMERCIAL HYPOTHESIS
      |
      v
ProgramProfile / Requirements
      |
      v
VERTICAL DEMO
      |
      v
DISCOVERY
      |
      +---- positioning changes
      +---- requirement changes
      +---- terminology changes
      +---- offer changes
      +---- account-score changes
      |
      v
PAID RELIANCE WORKFLOW
```

The commercial layer is not a disconnected sales folder. Discovery should feed back into ProgramProfiles, requirements, terminology, pricing, and demos.

## One Truth, Multiple Pitches

Do not maintain unrelated customer, investor, and founder decks.

The Company Pack should compile into different narratives.

### Customer

current workflow -> evidence problem -> bounded intervention -> first offer

### Investor

structural bottleneck -> wedge -> market -> economics -> moat -> expansion

### Founder

problem -> company opportunity -> what Foundry supplies -> what founder must own

### Technical Buyer

sources -> evidence -> requirements -> artifact -> verifier -> integration

Render pitches:

```sh
bin/factory pitch customer methaneproof
bin/factory pitch investor methaneproof
bin/factory pitch founder methaneproof
```

## Never Let Marketing Outrun The Evidence

Every Company Pack must declare what the company:

- does
- does not do
- can safely claim
- must qualify
- must not claim

An evidence company should be particularly disciplined about words such as:

- verified
- certified
- approved
- guaranteed
- compliant
- scored
- rated
- insured
- audited

The company must not imply institutional authority it does not possess.

Claim discipline lives at `ventures/<company>/brand/claim_discipline.yml`.

Check generated copy:

```sh
bin/factory claims check methaneproof
```

Pass explicit paths to check draft copy outside `generated/`:

```sh
bin/factory claims check methaneproof path/to/homepage.md path/to/deck.md
```

## Technical Quick Start

```sh
git clone https://github.com/mech-lab/AgEvidenceFoundry
cd AgEvidenceFoundry
bin/doctor
bin/demo
```

Then open `http://127.0.0.1:3000`.

If port 3000 is already in use, `bin/demo` selects the next open port and prints the URL.

Demo login:

- Email: `demo`
- Password: `demo`

Run a specific company pack:

```sh
bin/factory demo methaneproof
bin/factory demo fieldproof
bin/factory demo aglend
bin/factory demo supplierevidence
```

## Rails Reference Company

The Rails console in `apps/console` is the reference evidence business. It demonstrates:

- projects
- source records
- normalized evidence
- gaps
- evaluations
- review
- determinations
- artifacts
- downloadable bundles
- reliance
- verification
- ProgramProfiles
- API keys
- schemas
- OpenAPI
- logs
- webhooks

![AgEvidence evidence workspace overview](docs/screenshots/00-overview.png)

The reference company is deliberately complete enough to show the operating surface of an evidence-native agtech business before a founder specializes it into a vertical company.

## From Telemetry To Reliance

```text
YOUR AGTECH PRODUCT
  observations / interventions / models / operations
        |
        v
+----------------------------+
| agevidence                 |
| SourceRecord               |
| Observation                |
| InterventionEvent          |
| OperationalEvent           |
| ModelRun                   |
+-------------+--------------+
              |
              v
       Evidence Workspace
              |
       +------+------+
       v             v
  Evaluation       Gaps
       |             |
       +------+------+
              v
            Review
              |
              v
        Determination
              |
              v
       Issued Artifact
              |
      +-------+-------+
      v       v       v
    Buyer   Auditor  Bank
              |
              v
       Reliance Event
```

You do not need to rebuild this because your startup happens to sell feed additives, pasture intelligence, robotics, methane measurement, farm software, crop models, biological inputs, agricultural finance, or assurance.

## Product Substrate Tour

### Source Records

Source records preserve where evidence came from, how it is identified, and the custody/provenance information needed downstream.

![AgEvidence source records](docs/screenshots/02-source-records.png)

### Evidence

Product telemetry becomes typed evidence rather than a loose collection of application records.

![AgEvidence normalized evidence](docs/screenshots/03-evidence.png)

### Gaps

The workspace can turn buyer, methodology, program, or assurance requirements into explicit evidence gaps.

![AgEvidence evidence gaps](docs/screenshots/04-gaps.png)

### Evaluation

Machine-readable evidence and ProgramProfiles provide a repeatable assessment surface before a human reviewer makes a determination.

![AgEvidence assessment](docs/screenshots/05-assessment.png)

### Review

Review keeps human judgment explicit and inspectable.

![AgEvidence review workflow](docs/screenshots/06-review.png)

### Artifacts

The output is an artifact that can move beyond the application that produced it.

![AgEvidence issued artifact](docs/screenshots/07-artifact.png)

### Reliance

A buyer, bank, insurer, auditor, processor, or other relying party can become part of the evidence chain instead of being an off-platform endpoint.

![AgEvidence reliance record](docs/screenshots/08-reliance.png)

### Verification

Public verification gives downstream users a narrow surface for checking an issued record without needing access to the originating workspace.

![AgEvidence public verification](docs/screenshots/09-verification.png)

Current Rails verifier results are constrained by the verifier implementation available in this repo. Do not overstate independent verification in generated company copy.

## ProgramProfiles

AgEvidence primitives plus a ProgramProfile plus vertical UX becomes a new evidence company.

![AgEvidence ProgramProfiles](docs/screenshots/10-program-profile.png)

Use ProgramProfiles to encode requirements, evidence classes, evaluation modes, version impacts, limitation templates, and artifact policy. Keep the evidence identities, artifact structure, verification contract, and reliance records interoperable.

## Developer Surface

Developer workspace:

![AgEvidence developer workspace](docs/screenshots/11-developer.png)

Webhooks:

![AgEvidence webhooks](docs/screenshots/12-webhooks.png)

OpenAPI:

![AgEvidence OpenAPI](docs/screenshots/13-openapi.png)

The canonical machine-readable OpenAPI document lives at `protocol/openapi/agevidence-v1.yaml`.

## Embed The Evidence Layer

You can embed the evidence layer inside another product with the SDKs under `packages/`.

Python example:

```sh
pip install agevidence
```

```python
from agevidence import Client

client = Client(base_url="http://localhost:3000", api_token="agev_test_demo_2a10")

project = client.create_project(
    account_name="Northstar Methane Systems Sandbox",
    project_name="Enterprise dairy pilot",
    target_claim="The intervention reduces enteric methane.",
)

source = client.submit_source_record(
    project_id=project.id,
    document_id="feeding-event-001",
    evidence_type="agevidence.intervention_event.v1",
    controlled_uri="evidence://feeding-event-001",
    commitment="sha256:demo",
)
```

Ruby and Rust package work lives under `packages/ruby` and `packages/rust`.

## Development

Useful commands:

```sh
bin/doctor
bin/demo
bin/test
bin/factory doctor
bin/factory doctor methaneproof --verbose
bin/sync-upstream
```

Rails app:

```sh
cd apps/console
bin/rails test
```

Factory tests:

```sh
ruby factory/test/venture_pack_loader_test.rb
```

Trust core:

```sh
bash protocol/conformance/scripts/agevidence_check_all.sh
cd packages/rust && cargo test
cd packages/ruby && bundle exec rake
python -m pytest packages/python/tests
```

Research examples live under `research/`.

## Upstream Relationship

Foundry is a thin fork of AgEvidence.

```text
upstream = https://github.com/meronrudy/AgEvidence
origin   = https://github.com/mech-lab/AgEvidenceFoundry
```

Run:

```sh
bin/sync-upstream
```

Read [UPSTREAM.md](UPSTREAM.md) for source-of-truth rules.

Do not maintain permanent product branches such as `methaneproof`, `fieldproof`, `aglend`, and `supplierevidence`. Long-lived branches create drifting copies of the Rails app, schemas, verifier, SDKs, and migrations.

Use short-lived feature, venture, and sync branches that merge back into `main`.

## Extraction Model

During incubation, a venture lives inside `AgEvidenceFoundry`.

After external reliance and architecture review, a venture should either be extracted or retained according to `formation_architecture`:

```sh
bin/factory extract methaneproof --architecture independent ../MethaneProof
bin/factory extract methaneproof --architecture licensed-newco ../MethaneProof
bin/factory extract fieldproof --architecture parent-platform ../FieldProof
bin/factory extract aglend --architecture controlled-subsidiary ../AgLend
bin/factory retain supplierevidence --architecture internal-product
```

Those commands are planned. When implemented, the architecture compiler should decide which assets cross the boundary:

- code
- configurations
- ProgramProfiles
- integrations
- customer records
- data
- brand
- documentation
- licenses
- improvement obligations

For an extracted company repo, the output should be an operating company, not only a cloned Rails app:

```text
CompanyName/
├── product/
├── app/
├── protocol/
├── company/
├── sales/
├── investor/
├── design/
├── research/
└── AGEVIDENCE_ORIGIN
```

After extraction, the company should consume AgEvidence through versioned schemas, SDK packages, verifier releases, protocol releases, and conformance suites rather than repeatedly merging the whole Foundry repo. If the chosen architecture is parent-owned or internal, the compiler should retain the venture inside the parent operating surface and record the rationale in `formation_architecture.decision`.

## What Success Looks Like

AgEvidence Foundry is not successful because it contains many startup ideas. It is successful when validated opportunities can repeatedly emerge from the same substrate while sharing less undifferentiated work and allocating ownership where the value actually develops.

A founder should not need to invent:

- evidence identity
- provenance
- requirements machinery
- review infrastructure
- artifact structures
- verifier contracts
- generic API infrastructure
- basic account research grammar
- basic buyer-role taxonomy
- first-pitch structure
- company-formation process

They should need to invent the things that should actually make their company different:

- domain insight
- buyer relationships
- vertical semantics
- proprietary integrations
- proprietary models
- distribution
- customer experience
- market execution

The long-term goal is not to build every evidence-native agriculture company. It is to make those companies dramatically cheaper and faster to build.

> Start with the agricultural problem, not the evidence plumbing.
