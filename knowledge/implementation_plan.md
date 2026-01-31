# Implementation Plan: Fullstack Migration & Railway Deployment (Loki Autonomy)

## Objective
Convert the current static website into a professional Fullstack application (Next.js + Prisma + TypeScript) and deploy it to Railway using the `deploy-railway-fullstack` skill under `loki-mode` autonomous orchestration.

## Phase 1: Environment Setup & Bootstrapping
- [x] Initialize Next.js project.
- [x] Install dependencies: `prisma`, `@prisma/client`, `framer-motion`, `lucide-react`.
- [x] Initialize Prisma: `npx prisma init`.

## Phase 2: Content Migration (Vibe Check)
- [x] Extract CSS from `website/css/` and integrate into `src/app/globals.css`.
- [x] Convert all legacy pages into Next.js pages/components.
- [x] Preserve the "Premium Aesthetic" with animations and custom fonts.

## Phase 3: Fullstack Features
- [x] Configure `Prisma` with `ContactMessage` model.
- [x] Create API route for contact form.

## Phase 4: Production Optimization (Railway Skill)
- [x] Configure `next.config.js` with `output: "standalone"`.
- [x] Create optimized `Dockerfile`.
- [x] Create `.dockerignore`.
- [x] Run production build (`npm run build`) - SUCCESSFUL.

## Phase 5: Autonomous Assets
- [x] Generate premium Hero image using AI.
- [x] Organize public assets.

## Phase 5: Autonomous Deployment
- [ ] Login to Railway via Browser (if CLI is not possible).
- [ ] Create a new project and link the repository.
- [ ] Set up PostgreSQL and environment variables (`DATABASE_URL`).
- [ ] Trigger deployment.

## Phase 6: Verification & Sync
- [ ] Run automated tests or use Browser Agent to verify functionality.
- [ ] Update `CODEBASE_MAP.md` and `CONTINUITY.md`.
- [ ] Generate `Walkthrough.md`.

---
**Loki Mode Note**: Proceeding directly to Phase 1 as per autonomy rules.
