import 'unimas_grade.dart';

class Course {
  String name;      // e.g., "Data Structures"
  int creditHours;  // e.g., 3 or 4
  String grade;     // e.g., "A"

  Course({
    required this.name,
    required this.creditHours,
    required this.grade,
  });

  // This uses the logic file you just created to get the 4.00 value
  double get point => UnimasGrade.convertGradeToPoint(grade);

  // This calculates the weight (Credits * Point)
  // e.g., 3 credits * 4.00 = 12.00
  double get totalQualityPoints => point * creditHours;
}