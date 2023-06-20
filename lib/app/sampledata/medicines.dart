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
    '10MG',
    '200MG',
    '50MG',
    '100MG',
    '150MG',
    '650MG',
    '250MG',
    '600MG',
    '300MG'
  ];

  static List<String> hours = List.generate(
      12, (index) => '${index >= 9 ? index + 1 : '0${index + 1}'} H');

  static List<String> minute = List.generate(
      60, (index) => '${index >= 9 ? index + 1 : '0${index + 1}'} M');
}
