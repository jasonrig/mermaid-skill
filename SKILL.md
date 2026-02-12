---
name: design-mermaid-diagrams
description: Create and refine well-designed Mermaid diagrams (flowcharts, sequence diagrams, class or ER models, state diagrams, timelines, mindmaps, and architecture graphs) and render them to SVG, PNG, or PDF with Mermaid CLI. Use when a user asks for Mermaid chart creation, visual cleanup, layout optimization, or compiled diagram output.
---

# Mermaid Diagram Design

## Workflow

1. Clarify the goal, audience, and output format (`svg`, `png`, or `pdf`).
2. Pick the minimum diagram type that matches the request.
3. Draft structure first (groups, phases, boundaries, and decision points), then labels.
4. For exact grammar or parser-edge syntax, consult `references/syntax/` first.
5. Apply design rules from `references/mermaid-design-guide.md`.
6. Run mandatory render-validation with `scripts/dry_run_mermaid.sh` to confirm Mermaid syntax and basic layout.
7. If a final artifact is requested, render with `scripts/render_mermaid.sh` and fix parser or layout issues.
8. Iterate until crossings, spacing, and labels are readable at a glance.

## Diagram Selection

- `flowchart`: process logic, branching, and routing.
- `sequenceDiagram`: interactions over time between actors or services.
- `stateDiagram-v2`: lifecycle and transition logic.
- `classDiagram` or `erDiagram`: structure and relationship mapping.
- `timeline`: milestones and event progression.
- `mindmap`: concept mapping and taxonomy.
- `architecture-beta`: systems, boundaries, and dependencies.

## Official Syntax References

Use `references/syntax/` as the syntax source of truth whenever exact Mermaid grammar is needed.

- Start with the diagram-specific file in `references/syntax/` (for example `flowchart.md`, `sequenceDiagram.md`, `classDiagram.md`).
- Use `references/syntax/examples.md` for quick cross-type snippets.
- If syntax conflicts with memory, prefer the local `references/syntax/` docs for this installed docs snapshot.

### Supported Diagram/Chart Types In This Syntax Snapshot

- Architecture diagram: `architecture-beta` (`references/syntax/architecture.md`, v11.1.0+).
- Block diagram: `block` (`references/syntax/block.md`).
- C4 diagrams: `C4Context`, `C4Container`, `C4Component`, `C4Dynamic`, `C4Deployment` (`references/syntax/c4.md`, experimental).
- Class diagram: `classDiagram` (`references/syntax/classDiagram.md`).
- Entity relationship diagram: `erDiagram` (`references/syntax/entityRelationshipDiagram.md`).
- Flowchart: `flowchart` (alias `graph`) (`references/syntax/flowchart.md`).
- Gantt: `gantt` (`references/syntax/gantt.md`).
- Git graph: `gitGraph` (`references/syntax/gitgraph.md`).
- Kanban: `kanban` (`references/syntax/kanban.md`).
- Mindmap: `mindmap` (`references/syntax/mindmap.md`).
- Packet diagram: `packet` (`references/syntax/packet.md`, v11.0.0+).
- Pie chart: `pie` (`references/syntax/pie.md`).
- Quadrant chart: `quadrantChart` (`references/syntax/quadrantChart.md`).
- Radar diagram: `radar-beta` (`references/syntax/radar.md`, v11.6.0+).
- Requirement diagram: `requirementDiagram` (`references/syntax/requirementDiagram.md`).
- Sankey diagram: `sankey` (`references/syntax/sankey.md`, v10.3.0+, experimental).
- Sequence diagram: `sequenceDiagram` (`references/syntax/sequenceDiagram.md`).
- State diagram: `stateDiagram-v2` (`stateDiagram` legacy syntax also documented) (`references/syntax/stateDiagram.md`).
- Timeline diagram: `timeline` (`references/syntax/timeline.md`).
- Treemap diagram: `treemap-beta` (`references/syntax/treemap.md`, new/experimental).
- User journey: `journey` (`references/syntax/userJourney.md`).
- XY chart: `xychart` (`references/syntax/xyChart.md`).
- ZenUML: `zenuml` (`references/syntax/zenuml.md`).

## Authoring Rules

- Keep one primary reading direction (`TB` or `LR`) unless the diagram type dictates otherwise.
- Keep node labels short (2 to 6 words); move detail into notes or legends.
- Use `subgraph` blocks to create visual hierarchy and reduce line crossings.
- Split dense hubs into intermediate nodes instead of using many direct edges.
- Use `classDef` styles intentionally with a limited palette (2 to 4 semantic colors).
- Add legends only when colors or line styles encode meaning.

## Sandbox requirement:

- Execute `dry_run_mermaid.sh` and `render_mermaid.sh` outside the sandbox (use escalated permissions).
- Use `npx -y` to avoid interactive install prompts.

## Mermaid CLI Quick Reference

Captured from `npx -y -p @mermaid-js/mermaid-cli mmdc -h`.

- Input and output: `-i/--input`, `-o/--output`, `-e/--outputFormat`, `-a/--artefacts`.
- Sizing and render: `-w/--width`, `-H/--height`, `-s/--scale`, `-f/--pdfFit`.
- Theme and style: `-t/--theme`, `-b/--backgroundColor`, `-C/--cssFile`, `-I/--svgId`.
- Config files: `-c/--configFile`, `-p/--puppeteerConfigFile`.
- Logging and metadata: `-q/--quiet`, `-V/--version`, `-h/--help`.
- Markdown extraction is built-in when input ends with `.md`.

Read full help output in `references/mmdc-help.txt`.

## Output Expectations

- Return Mermaid source and a short rationale for key design choices.
- Preserve stable node IDs across revisions when possible.
- Run `scripts/dry_run_mermaid.sh` at least once per diagram before finalizing.
- If a final artifact is requested, render it with `scripts/render_mermaid.sh` after dry-run validation.
- If compilation fails, report the exact parser error and the corrected snippet.
