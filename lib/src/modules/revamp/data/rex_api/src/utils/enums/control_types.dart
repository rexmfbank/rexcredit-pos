// enum ControlTypes {
//   atmAllowed('ATM_ALLOWED', 'Atm Allowed'),
//   posAllowed('POS_ALLOWED', 'Pos Allowed'),
//   contactlessAllowed('CONTACTLESS_ALLOWED', 'Contactless Allowed'),
//   crossBorderAllowed('CROSS_BORDER_ALLOWED', 'Cross Border Allowed'),
//   webAllowed('WEB_ALLOWED', 'Web Allowed'),
//   none('NONE', 'None');

//   const ControlTypes(this.jsonString, this.displayString);
//   final String jsonString;
//   final String displayString;
// }

// extension ControlTypesFromString on String? {
//   ControlTypes? get controlTypes {
//     return ControlTypes.values.firstWhere(
//           (element) => element.jsonString == this,
//       orElse: () => ControlTypes.none,
//     );
//   }

//   ControlTypes? get jsonControlTypes {
//     return ControlTypes.values.firstWhere(
//           (element) => element.displayString == this,
//       orElse: () => ControlTypes.none,
//     );
//   }
// }
