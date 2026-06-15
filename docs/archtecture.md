# Picante System Architecture

This document describes the planned evolution of the Picante internal business management system.

---

## Phase 1: Initial MVP

**Goal:** Build a functional internal system quickly.

```text
Retool
   ↓
Supabase
   ↓
PostgreSQL
```

### Characteristics

- Retool used as the staff interface
- Supabase provides database access
- Rapid development and deployment
- Minimal security controls
- Focus on validating workflows

---

## Phase 2: Access Control

**Goal:** Enforce role and branch restrictions.

```text
Retool
   ↓
Supabase
   ↓
PostgreSQL

Security Layer:
- Role-Based Access Control (RBAC)
- Row Level Security (RLS)
```

### Characteristics

- Staff only access authorized data
- Branch-level data isolation
- Reduced risk of unauthorized access
- Security enforced at the database layer

---

## Phase 3: Audit & Accountability

**Goal:** Add traceability and monitoring.

```text
Retool
   ↓
Supabase
   ↓
PostgreSQL

Security Layer:
- Role-Based Access Control (RBAC)
- Row Level Security (RLS)
- Audit Logging
```

### Characteristics

- Track sensitive actions
- Record who performed changes
- Record when changes occurred
- Support incident investigation and accountability

---

## Phase 4: Backend Security Layer

**Goal:** Centralize business logic and security controls.

```text
Retool
   ↓
Node.js API
   ↓
Supabase
   ↓
PostgreSQL

Security Layer:
- Role-Based Access Control (RBAC)
- Row Level Security (RLS)
- Audit Logging
```

### Characteristics

- Centralized business logic
- Consistent validation of requests
- Improved security controls
- Better scalability and maintainability
- Reduced direct database exposure

---

## Long-Term Vision

The Picante system is intended to evolve from a simple internal management tool into a secure, production-style business system that demonstrates:

- Secure database design
- Role-based access control
- Auditability
- Business process automation
- Cybersecurity-focused architecture
