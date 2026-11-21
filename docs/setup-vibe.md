# setup-vibe

## 它做什么

把你的"工作环境"写进一个仓库：

- `CODING_STANDARDS.md`：代码规范，九节（开闭原则、Adapter、模块边界、不硬编码、接口唯一定义、页面状态、错误处理、测试、文件放置）。`code-review` 每次审查都会读它。
- `docs/FILE_CONVENTIONS.md`：文件放置约定。Agent 建文件前对照它。
- `AGENTS.md`（或 `CLAUDE.md`）里的 `## Working habits` 一段：每张票的工作习惯，每次会话都会加载。
- `docs/agents/issue-tracker.md` 末尾的关票约定、`.gitignore` 的几行。

写完后做一次初始提交。之后这些文件就是规则的唯一来源，你直接改它们就行。

它的做法和 `/setup-matt-pocock-skills` 一样：先看仓库，列出发现，一次问你一个问题（推荐答案放第一个），给你看草稿，你同意了才写。

## 什么时候用

- 每个仓库一次，在 `/setup-matt-pocock-skills` 之后。没跑过 Matt 的 setup，它会让你先去跑，然后停下。
- Matt 的 setup 要选**本地 markdown**（Local markdown）追踪器。选了 GitHub 等其他追踪器，它会说明这套流程不适用，然后停下。
- 平时改规则直接改项目里的文件，不用重跑。只有模板更新了、想把新规则合并进旧项目时才重跑，它会合并而不是覆盖。

## 常见问题

**会不会覆盖我已有的 `CODING_STANDARDS.md` 或 `AGENTS.md`？** 不会。已有文件它会问你要不要合并，保留你的规则；`## Working habits` 已存在就原地更新，其他段落不动。

**它会把我没提交的改动一起提交吗？** 不会。它只暂存自己写过的文件。

**为什么会多出一个只有一行 `@AGENTS.md` 的 `CLAUDE.md`？** Claude Code 默认读 `CLAUDE.md`。你同时用 Codex 和 Claude Code 时，这一行让两边读到同一份工作习惯。它会先问你。

**以后重跑 `/setup-matt-pocock-skills` 要注意什么？** Matt 的 setup 在 `CLAUDE.md` 存在时会改 `CLAUDE.md`，它的 `## Agent skills` 一段可能写进那个一行的文件。跑完把那段移回 `AGENTS.md`。

**它提示 `tdd` 不对怎么办？** 说明本机的 `tdd` 被别的技能包（比如 pstack）的同名版本覆盖了，`implement` 会跳过红绿循环。先装回 Matt 的 `tdd` 再开始做票。它自己不改已安装的 Skill。

**全新文件夹也能用吗？** 能。它会先 `git init -b main`。如果本机还没设置 git 的用户名和邮箱，它会先问你，不会自己编。

**它问的"Full process"是什么？** 可选项。如果你有一份更完整的流程文档（团队 SOP、发布清单），把路径或网址告诉它，它会写进项目的 `## Working habits`。以后碰到对外发布、处理别人的数据、高风险改动时，`/ask-vibe` 会指向这份文档。没有就说"没有"，`/ask-vibe` 会直接告诉你那种情况需要补哪些保障。路径按你自己电脑上的位置填，不会写进 Skill 本身。

**模板为什么是英文？** 这几个文件主要是给 Agent 读的，和 Matt 的 Skill 一致更稳。产品规格、术语表和界面文案仍按项目语言写，`## Working habits` 里有这一条。

## 怎样算在正常工作

- 仓库里有 `CODING_STANDARDS.md`、`docs/FILE_CONVENTIONS.md`，`AGENTS.md` 里有 `## Working habits`。
- `git rev-parse HEAD` 能输出提交号；`git check-ignore -v .scratch/x` 没有任何输出。
- 之后每张票的审查报告里，Standards 一项会引用 `CODING_STANDARDS.md` 的条目。
