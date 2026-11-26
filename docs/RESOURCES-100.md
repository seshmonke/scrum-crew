# 100 ресурсов

Отобрано по темам: Scrum и церемонии, мультиагентные системы, skills и
спецификации, git/CI/поставка, качество и безопасность веба, продукт и UX.

Обозначения:
- ● — открыт и прочитан в этой сессии;
- ○ — проверен на доступность (HTTP 2xx), канонический первоисточник;
- △ — страница существует, но отдаёт 403/таймаут автоматической проверке.

Проверка ссылок: 99 из 100 ответили 2xx/3xx; `age-of-product.com` отдаёт
403 ботам. Даты и версии источников могут меняться — сверяйтесь с
первоисточником.

---

## A. Scrum и agile (1–18)

1. ● [The 2020 Scrum Guide](https://scrumguides.org/scrum-guide.html) —
   единственный первоисточник правил: события, артефакты, обязательства.
2. ○ [Scrum Guide 2020, PDF](https://scrumguides.org/docs/scrumguide/v2020/2020-Scrum-Guide-US.pdf) —
   версия для цитирования и печати.
3. ● [Scrum Guide Revisions](https://scrumguides.org/revisions.html) —
   что изменилось в 2020: одна команда, Product Goal, DoD.
4. ● [What is a Definition of Done?](https://www.scrum.org/resources/what-definition-done) —
   DoD как обязательство инкремента.
5. ○ [What is a Sprint Goal?](https://www.scrum.org/resources/what-sprint-goal) —
   цель спринта как обязательство Sprint Backlog.
6. ○ [What is a Product Goal?](https://www.scrum.org/resources/what-product-goal) —
   долгосрочный фокус продукта.
7. ○ [What is a Product Backlog?](https://www.scrum.org/resources/what-is-a-product-backlog) —
   один бэклог, один порядок.
8. ○ [What is a Sprint Backlog?](https://www.scrum.org/resources/what-is-a-sprint-backlog) —
   почему, что и как спринта.
9. ○ [What is an Increment?](https://www.scrum.org/resources/what-is-an-increment) —
   инкремент как проверенный шаг к цели.
10. ○ [Scrum Guide 2020 Updates](https://www.scrum.org/scrum-guide-2020) —
    разбор изменений от Scrum.org.
11. ○ [What is Scrum?](https://www.scrum.org/resources/what-is-scrum) —
    краткий вход для новых участников.
12. △ [Scrum Commitments](https://age-of-product.com/scrum-commitments/) —
    Product Goal, Sprint Goal, DoD как три обязательства.
13. ● [Definition of Ready](https://www.atlassian.com/agile/project-management/definition-of-ready) —
    DoR и INVEST без превращения в бюрократический гейт.
14. ○ [Agile Alliance: Definition of Ready](https://agilealliance.org/glossary/definition-of-ready/) —
    словарное определение и границы применимости.
15. ○ [INVEST in Good Stories](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/) —
    исходная статья Билла Уэйка.
16. ○ [User Stories](https://www.mountaingoatsoftware.com/agile/user-stories) —
    практика формулировки и разрезания историй.
17. ○ [Feature Team Primer](https://featureteamprimer.org/) —
    почему компонентные команды порождают очередь и handoff.
18. ● [Siloed QA Team](https://beyond.minimumcd.org/docs/anti-patterns/organizational-cultural/governance-process/siloed-qa-team) —
    антипаттерн «разработка → QA-очередь».

## B. Мультиагентные системы (19–40)

19. ● [Anthropic: multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system) —
    orchestrator-worker, границы применимости, цена параллельности.
20. ● [Anthropic: coordination patterns](https://claude.com/resources/articles/multi-agent-coordination-patterns) —
    пять топологий и когда какая ломается.
21. ○ [Anthropic: building effective agents](https://www.anthropic.com/engineering/building-effective-agents) —
    начинать с простого, не плодить агентов без нужды.
22. ○ [Anthropic: context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) —
    контекст как управляемый ресурс.
23. ● [Microsoft: AI agent design patterns](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/guide/ai-agent-design-patterns) —
    антипаттерны координации и HITL.
24. ● [Microsoft Agent Framework: orchestrations](https://learn.microsoft.com/en-us/agent-framework/workflows/orchestrations) —
    детерминированные и агентные workflow.
25. ● [AWS: orchestration patterns](https://builder.aws.com/content/3AtvWf5Z0DfZLINb0E4iVFHWzeG/building-multi-agent-applications-or-orchestration-patterns) —
    восемь паттернов, включая dynamic worker pool.
26. ● [LlamaIndex: multi-agent](https://developers.llamaindex.ai/python/framework/understanding/agent/multi_agent) —
    agents-as-tools и handoff.
27. ● [QueryNow: supervisor, handoffs, graphs](https://www.querynow.com/ai-agents/orchestration/multi-agent-patterns) —
    почему supervisor — узкое место и как его разгружать.
28. ● [Nebula: field guide](https://www.nebula.gg/blog/multi-agent-orchestration-patterns) —
    state, identity, failure handling, observability.
29. ● [Databricks: orchestration patterns](https://answers.databricks.com/patterns-work-orchestrating-multi-agent-workflows) —
    supervisor как корпоративный default.
30. ● [MetaGPT paper](https://arxiv.org/abs/2308.00352) — Code = SOP(Team):
    структурированные артефакты вместо свободного чата.
31. ● [MetaGPT repo](https://github.com/FoundationAgents/MetaGPT) —
    роли PM/architect/engineer и общий message pool.
32. ● [ChatDev paper](https://aclanthology.org/2024.acl-long.810.pdf) —
    коммуникативные агенты, цикл instructor/assistant.
33. ● [ChatDev repo](https://github.com/OpenBMB/ChatDev) —
    эволюция в zero-code orchestration.
34. ● [IBM: MetaGPT](https://www.ibm.com/think/topics/metagpt) —
    почему SOP и структурный вывод снижают галлюцинации.
35. ● [IBM: ChatDev](https://www.ibm.com/think/topics/chatdev) —
    сравнение multi-agent и single-agent.
36. ● [DeepLearning.AI: multi-agent collaboration](https://www.deeplearning.ai/the-batch/agentic-design-patterns-part-5-multi-agent-collaboration/) —
    роли, память, планирование, пределы предсказуемости.
37. ○ [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/) —
    handoffs, guardrails, tracing.
38. ○ [LangGraph](https://langchain-ai.github.io/langgraph/) —
    граф состояния и durable execution.
39. ○ [Temporal](https://temporal.io/) —
    durable workflow, если оркестратор перерастёт файлы.
40. ○ [A2A Protocol](https://a2a-protocol.org/) —
    межфреймворковое взаимодействие агентов.

## C. Skills, спецификации, методология (41–58)

41. ● [GitHub Spec Kit](https://github.com/github/spec-kit) —
    constitution → specify → plan → tasks → implement.
42. ● [Spec Kit Quickstart](https://github.github.com/spec-kit/quickstart.html) —
    полный и короткий маршруты, quality gates.
43. ● [Spec Kit: Agentic SDD](https://github.com/github/spec-kit/blob/main/docs/reference/agentic-sdd.md) —
    точные обязанности каждой команды.
44. ● [Martin Fowler: SDD tools](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html) —
    spec-kit, Kiro, Tessl: что general, что vendor-specific.
45. ● [GitHub: SDD toolkit](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/) —
    почему спецификация становится источником истины.
46. ● [AGENTS.md](https://agents.md/) — открытый формат инструкций для
    кодирующих агентов.
47. ● [OpenAI: AGENTS.md guide](https://developers.openai.com/codex/guides/agents-md) —
    цепочка discovery и приоритеты.
48. ● [Linux Foundation: AAIF](https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation) —
    AGENTS.md, MCP и goose под нейтральным управлением.
49. ● [Anthropic: Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) —
    progressive disclosure и структура скилла.
50. ● [Agent Skills specification](https://agentskills.io/specification) —
    каноническая структура SKILL.md и ресурсов.
51. ● [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) —
    < 500 строк, описание с триггерами, тестирование.
52. ● [Claude Code best practices](https://code.claude.com/docs/en/best-practices) —
    spec-first, subagents, review against spec.
53. ○ [Claude Code subagents](https://code.claude.com/docs/en/sub-agents) —
    изоляция контекста и права.
54. ● [BMad Method](https://docs.bmad-method.org/) — роли-агенты и ticket-as-spec.
55. ● [How BMad works](https://docs.bmad-method.org/start/how-bmad-works/) —
    clarify → plan → build → review, шесть агентов.
56. ● [OpenCode: agents](https://opencode.ai/docs/agents/) —
    subagent, permissions, model, steps.
57. ● [OpenCode: skills](https://opencode.ai/docs/skills/) —
    `.opencode/skills/<id>/SKILL.md`, загрузка по требованию.
58. ○ [Cursor: rules](https://cursor.com/docs/context/rules) —
    проектные и path-specific правила.

## D. Git, PR, CI и поставка (59–76)

59. ● [GitHub: protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches) —
    required checks, reviews, linear history.
60. ● [GitHub: merge queue](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue) —
    очередь и `merge_group`.
61. ● [GitHub: rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets) —
    правила, применимые к веткам и тегам.
62. ○ [GitHub Actions](https://docs.github.com/en/actions) —
    CI/CD и события.
63. ● [GitHub: stacked PRs](https://docs.github.com/en/pull-requests/reference/stacked-pull-requests) —
    зависимые PR без ожидания.
64. ○ [Google eng practices: code review](https://google.github.io/eng-practices/review/) —
    маленькие CL, скорость ревью, что искать.
65. ● [Trunk Based Development](https://trunkbaseddevelopment.com/) —
    короткоживущие ветки и ежедневная интеграция.
66. ● [TBD: short-lived branches](https://trunkbaseddevelopment.com/short-lived-feature-branches/) —
    один автор/агент на ветку.
67. ● [TBD: continuous review](https://trunkbaseddevelopment.com/continuous-review/) —
    ревью за минуты, а не за дни.
68. ● [DORA: trunk-based development](https://dora.dev/capabilities/trunk-based-development/) —
    ≤ 3 активных ветки, мерж ежедневно.
69. ● [DORA: continuous integration](https://dora.dev/capabilities/continuous-integration/) —
    тесты до и после мержа, красный trunk чинят немедленно.
70. ● [DORA: metrics guide](https://dora.dev/guides/dora-metrics-four-keys/) —
    lead time, frequency, recovery, change fail rate.
71. ○ [Conventional Commits](https://www.conventionalcommits.org/) —
    машинно-читаемые сообщения коммитов.
72. ○ [Keep a Changelog](https://keepachangelog.com/) —
    changelog для людей, а не git log.
73. ○ [git worktree](https://git-scm.com/docs/git-worktree) —
    несколько рабочих деревьев на один репозиторий.
74. ● [CircleCI: parallel coding agents](https://circleci.com/blog/parallel-coding-agents/) —
    изоляция worktree, портов и БД.
75. ● [OpenReplay: worktrees для агентов](https://blog.openreplay.com/git-worktrees-ai-agents) —
    один агент = одна ветка = один worktree.
76. ● [PostHog: code review без бутылочного горла](https://posthog.com/newsletter/code-review-tips) —
    автор не ревьюит себя, несколько ревьюеров с разными линзами.

## E. Качество, безопасность, веб (77–94)

77. ● [OWASP Top 10 for LLM Applications](https://genai.owasp.org/llm-top-10/) —
    prompt injection, excessive agency, supply chain.
78. ● [OWASP Top 10 for Agentic Applications 2026](https://genai.owasp.org/top-10-for-agentic-applications-2026/) —
    ASI01–ASI10: goal hijack, tool misuse, rogue agents.
79. ● [OWASP AI Agent Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/AI_Agent_Security_Cheat_Sheet.html) —
    least privilege, память, adversarial testing.
80. ● [OWASP Prompt Injection Prevention](https://cheatsheetseries.owasp.org/cheatsheets/LLM_Prompt_Injection_Prevention_Cheat_Sheet.html) —
    границы инструкций и данных, RAG-отравление.
81. ○ [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/) —
    проверяемые требования к безопасности приложения.
82. ○ [OWASP Top 10 Web](https://owasp.org/www-project-top-ten/) —
    базовый язык для authz, injection, SSRF.
83. ○ [WCAG 2.2](https://www.w3.org/TR/WCAG22/) —
    критерии доступности, на которые ссылается DoD.
84. ○ [WAI-ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apg/) —
    клавиатура, фокус, роли, паттерны компонентов.
85. ○ [web.dev: Core Web Vitals](https://web.dev/articles/vitals) —
    LCP, INP, CLS и пороги.
86. ○ [web.dev: Learn Performance](https://web.dev/learn/performance) —
    системный курс по производительности.
87. ○ [NN/g: 10 usability heuristics](https://www.nngroup.com/articles/ten-usability-heuristics/) —
    эвристики для дизайна и приёмки.
88. ○ [NN/g: progressive disclosure](https://www.nngroup.com/articles/progressive-disclosure/) —
    частое на поверхности, редкое — внутрь.
89. ● [NN/g: synthetic users](https://www.nngroup.com/articles/synthetic-users/) —
    почему синтетический пользователь не заменяет живого.
90. ○ [The Twelve-Factor App](https://12factor.net/) —
    конфиг, процессы, логи, сборка/релиз.
91. ○ [Google SRE Book](https://sre.google/sre-book/table-of-contents/) —
    SLO, error budget, инциденты, toil.
92. ○ [Martin Fowler: Continuous Integration](https://martinfowler.com/articles/continuousIntegration.html) —
    интеграция как практика, а не сервер.
93. ○ [Martin Fowler: ADR](https://martinfowler.com/bliki/ArchitectureDecisionRecord.html) —
    решения с контекстом и последствиями.
94. ○ [adr.github.io](https://adr.github.io/) —
    шаблоны и инструменты Architecture Decision Records.

## F. Продукт, UX, документация, эксплуатация (95–100)

95. ○ [Team Topologies](https://teamtopologies.com/) —
    stream-aligned, platform, enabling; границы ответственности.
96. ○ [MinimumCD](https://minimumcd.org/) —
    минимальный набор практик непрерывной поставки.
97. ○ [The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html) —
    сколько unit/integration/e2e и зачем.
98. ○ [Playwright](https://playwright.dev/) —
    e2e, трассировки, изоляция браузеров.
99. ○ [Semgrep docs](https://semgrep.dev/docs/) —
    SAST-правила и CI-интеграция.
100. ○ [GitHub Dependabot](https://docs.github.com/en/code-security/dependabot) —
     обновления зависимостей и security-алерты.

---

## Что читать первым, если времени мало

1. Scrum Guide 2020 (1) — правила, которые нельзя нарушать.
2. DoD (4) и Sprint Goal (5) — без них спринт превращается в отчёт.
3. Feature Team Primer (17) и Siloed QA (18) — почему не «репозиторий на
   роль» и не «QA после разработки».
4. Anthropic multi-agent (19) и Microsoft patterns (23) — пределы
   параллельности и координации.
5. Spec Kit (41–43) и AGENTS.md (46) — как писать спецификацию и правила.
6. OWASP Agentic Top 10 (78) — безопасность автономных агентов.
7. DORA TBD/CI (68–70) — почему маленькие PR и зелёный trunk важнее
   скорости генерации.
8. NN/g synthetic users (89) — почему User Proxy не имеет права вето.

---

## Приложение: OpenSpec (сверх 100)

Добавлено после решения встроить OpenSpec в методологию.

- ● [OpenSpec](https://openspec.dev/) — официальный сайт и обзор
  workflow.
- ● [OpenSpec Docs](https://openspec.dev/docs) — карта документации.
- ● [Quickstart](https://openspec.dev/docs/quickstart) — explore → propose →
  review → apply → archive.
- ● [CLI reference](https://openspec.dev/docs/cli) — `init`, `new`, `show`,
  `validate`, `archive`, `status`, `list`, `view`.
- ● [Installation](https://openspec.dev/docs/installation) — Windows
  PowerShell, npm, standalone.
- ● [Supported tools](https://openspec.dev/docs/supported-tools) —
  `--tools opencode`, `.agents/skills/`.
- ● [spec-driven schema](https://openspec.dev/docs/schemas/spec-driven) —
  proposal / specs / design / tasks.
- ● [GitHub: Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec) —
  исходники, примеры спеков и изменений.

