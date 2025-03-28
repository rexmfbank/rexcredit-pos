class RolePermission {
  final String title;
  final String description;

  const RolePermission({
    required this.title,
    required this.description,
  });
}

const rolePermissionList = <RolePermission>[
  RolePermission(
    title: 'Borrow',
    description: 'Access to borrow loan',
  ),
  RolePermission(
    title: 'Cashflow',
    description: 'Access to see organization revenue',
  ),
  RolePermission(
    title: 'Employee',
    description: 'Access to manage your employees',
  ),
  RolePermission(
    title: 'Inventory',
    description: 'Access to inventory management',
  ),
  RolePermission(
    title: 'Cards',
    description: 'Access to virtual card',
  ),
  RolePermission(
    title: 'Invoice',
    description: 'Access to invoices',
  ),
  RolePermission(
    title: 'Receipt',
    description: 'Access to receipt',
  ),
  RolePermission(
    title: 'Payment Link',
    description: 'Access to create a payment link',
  ),
  RolePermission(
    title: 'Profile',
    description: 'Access to manage business profile',
  ),
];
