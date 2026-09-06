# Pitching

Pitches are compiled from shared operating truth, not handwritten as separate canonical documents.

Source files live under `ventures/<venture>/pitch/`:

- `thesis.yml`
- `customer.yml`
- `investor.yml`
- `founder.yml`
- `architecture.yml`
- `proof_points.yml`

Render a pitch to Markdown:

```sh
bin/factory pitch customer methaneproof
bin/factory pitch investor methaneproof
bin/factory pitch founder methaneproof
```

Customer, investor, founder, and architecture narratives should share facts while emphasizing different decisions.
