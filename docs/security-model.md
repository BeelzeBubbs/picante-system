# Security Model

## Roles

### Admin

Permissions:
- Full system access
- Manage users
- Manage branches
- View all reports
- Modify system settings

### Manager

Permissions:
- View assigned branch data
- Manage branch inventory
- View branch reports
- Manage branch staff

Restrictions:
- Cannot access other branches
- Cannot modify system settings

### Staff

Permissions:
- Create orders
- Update inventory counts
- View assigned branch data

Restrictions:
- Cannot view other branches
- Cannot manage users
- Cannot delete inventory records