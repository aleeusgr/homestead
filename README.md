# Homestead

Zork-inspired personal website — a text adventure meets online presence.
What does it mean to exist on the internet? Homestead explores this question
by giving you a web console that talks back.

```shell
/ Today is the 63rd of The Aftermath    \
| 3189. You are standing west of house. |
\ There is a note at the wall.          /
 --------------------------------------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
[guest $]
```

## Getting Started

**Prerequisites:** PHP

```bash
./serve.sh
# open http://localhost:8080/webconsole.php
```

Credentials are set in `webconsole.php` (lines 14-15).
Set `$NO_LOGIN = true` to skip authentication during development.

### Nix Container (deployment)

```bash
nix build .#nixosConfigurations.container.config.system.build.toplevel
```

### Jekyll Blog (GitHub Pages)

```bash
jekyll serve
```

---

## Milestones

### Milestone 1 — The Question of Presence

> What does it mean to be online?

An online presence is not just a website. It is a room someone can walk into.
The web console is that room: a terminal in the browser, a door into a server.
Before we teach it to speak, we learn to listen.

**Deliverables:**
- Web console running locally and in a Nix container
- Safe testing interface for AI development (no sensitive data exposed)
- Philosophical framing: presence as participation, not publication

### Milestone 2 — The Listener

> Can an AI understand what you mean, not just what you say?

Intent categorization: each incoming message is classified before processing.
Chat persistence: the interlocutor remembers the context of conversation.
We integrate LLMs (via Ollama) to understand human messages in a text adventure
interface. The console becomes a companion that knows the history.

**Deliverables:**
- Intent classifier (greeting, command, question, reflection, departure)
- Chat history persisted locally (session memory)
- Ollama integration for message understanding
- Zork-like response generation with context awareness

### Milestone 3 — The Companion

> A personal AI that remembers you.

The web console is no longer just a terminal — it is a place that knows you.
Your conversations shape the world. The companion learns your patterns,
anticipates your needs, and speaks to you in the language of text adventures.

**Deliverables:**
- Personalized responses based on interaction history
- Dynamic world-building from conversation context
- Zalo integration for external message handling
- Documentation of the full system as a model for digital sovereignty

---

## Reference

- https://en.wikipedia.org/wiki/Multi-user_dungeon
- https://en.wikipedia.org/wiki/Eric_S._Raymond
- Maurer, Bill (1998) "Cyberspatial Sovereignties: Offshore Finance, Digital Cash, and the Limits of Liberalism," Indiana Journal of Global Legal Studies: Vol. 5: Iss. 2, Article 7. Available at: https://www.repository.law.indiana.edu/ijgls/vol5/iss2/7
- https://medium.com/@alexeusgr/homestead-a-digital-sovereignty-85544ba596f7


