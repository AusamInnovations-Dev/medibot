class SampleMedicine {
  static List<String> sampleMedicines = [
    'lisinopril (Zestril)',
    'levothyroxine (Synthroid)',
    'atorvastatin (Lipitor)',
    'metformin (Glucophage)',
    'simvastatin (Zocor)',
    'omeprazole (Prilosec)',
    'amlodipine (Norvasc)',
    'metoprolol (Lopressor)',
    'acetaminophen plus hydrocodone',
    'albuterol (Ventolin)',
    'crosine (Ventolin)',
    'paracetamol (Ventolin)',
    'paracetamol (Ventolin)',
    'asperin (Ventolin)',
    'Nemosulite (Ventolin)',
    'Alex (Ventolin)',
    'Dolo 650MG (Ventolin)',
  ];

  static List<String> medicinePower = [
    'Select Dosage',
    'μg',
    'mg',
    'Table Spoon',
    'Tea Spoon',
    'ml',
  ];

  static List<String> hours = List.generate(
      12, (index) => '${index >= 9 ? index + 1 : '0${index + 1}'} H');

  static List<String> minute = [
    '00 M',
    '15 M',
    '30 M',
    '45 M',
  ];

  static List<String> medicineCategory = [
    'Tablet',
    'Syrup',
    'Eye Drop',
    'Ointment',
    'Injection'
  ];
}
