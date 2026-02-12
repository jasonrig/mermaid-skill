# Mermaid Design Guide

## Layout Checklist

- Choose one flow direction and keep it consistent.
- Group related nodes with `subgraph` and clear titles.
- Keep edge count per node low; split overloaded hubs.
- Prefer orthogonal reading paths over crisscross diagonals.
- Keep diagram depth balanced; avoid one very long branch.

## Labeling Checklist

- Use action-first labels (`Validate Order`, `Fetch Quotes`).
- Keep labels short and scannable.
- Keep tense and grammar consistent across the diagram.
- Use abbreviations only if they are obvious to the audience.

## Styling Checklist

- Define semantic classes once, then reuse.
- Use color for meaning, not decoration.
- Keep line and border weights consistent.
- Maintain strong foreground-background contrast.
- Avoid more than 2 to 4 semantic colors.

## Flowchart Pattern

```mermaid
flowchart LR
    classDef action fill:#e6f2ff,stroke:#0059b3,color:#00264d
    classDef decision fill:#fff4cc,stroke:#996f00,color:#3d2b00
    classDef terminal fill:#e8ffe8,stroke:#2f7d32,color:#123a14

    A([Start]):::terminal --> B[Collect Inputs]:::action
    B --> C{Input Valid?}:::decision
    C -->|Yes| D[Run Analysis]:::action
    C -->|No| E[Return Fixes]:::action
    D --> F([End]):::terminal
    E --> F
```

## Sequence Diagram Pattern

```mermaid
sequenceDiagram
    autonumber
    participant UI as Client UI
    participant API as Research API
    participant DB as Market Store

    UI->>API: Request screener run
    API->>DB: Load universe
    DB-->>API: Symbols + metadata
    API-->>UI: Stream progress updates
```

## State Diagram Pattern

```mermaid
stateDiagram-v2
    [*] --> Draft
    Draft --> Reviewed: Submit
    Reviewed --> Approved: Accept
    Reviewed --> Draft: Rework
    Approved --> Archived: Close
```

## ER Diagram Pattern

```mermaid
erDiagram
    STRATEGY ||--o{ SIGNAL : emits
    SIGNAL }o--|| INSTRUMENT : references
    RUN ||--o{ SIGNAL : captures
```

## Common Fixes

- Parser error near label: quote labels with punctuation.
- Overlapping links: add intermediate routing nodes.
- Dense center region: split into multiple `subgraph` blocks.
- Visual noise: remove redundant arrows and duplicate labels.
