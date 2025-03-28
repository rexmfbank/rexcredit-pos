class RoleName {
  final String title;
  final String description;

  const RoleName({
    required this.title,
    required this.description,
  });
}

const roleNamesList = <RoleName>[
  RoleName(
    title: 'Account Manager',
    description: '4 user(s) assigned',
  ),
  RoleName(
    title: 'HR Manager',
    description: '2 user(s) assigned',
  ),
  RoleName(
    title: 'Role Title',
    description: '0 user(s) assigned',
  ),
];
