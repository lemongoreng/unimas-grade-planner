import 'package:flutter/material.dart';
import '../models/course.dart';
import '../data/unimas_curriculum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Load the data from our static file
  List<Course> courses = UnimasCurriculum.allCourses;

  // 2. Variable to store the calculated CGPA
  double cgpa = 0.00;
  int totalCreditsEarned = 0;

  @override
  void initState() {
    super.initState();
    _calculateCGPA(); // Calculate once on startup
  }

  // 3. Logic to calculate the GPA
  void _calculateCGPA() {
    double totalPoints = 0;
    int credits = 0;

    for (var course in courses) {
      // Only calculate if a grade has been assigned
      if (course.grade != null) {
        totalPoints += course.totalQualityPoints;
        credits += course.creditHours;
      }
    }

    setState(() {
      totalCreditsEarned = credits;
      if (credits > 0) {
        cgpa = totalPoints / credits;
      } else {
        cgpa = 0.00;
      }
    });
  }

  // 4. Show a dialog to pick a grade
  void _showGradeDialog(Course course) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Select Grade for ${course.code}'),
          children: [
            // List of UNIMAS Grades
            for (var grade in ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F'])
              SimpleDialogOption(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Text(grade, style: const TextStyle(fontSize: 16)),
                onPressed: () {
                  setState(() {
                    course.grade = grade; // Update the course grade
                    _calculateCGPA();     // Recalculate CGPA immediately
                  });
                  Navigator.pop(context); // Close the dialog
                },
              ),
            // Option to remove a grade (reset)
            SimpleDialogOption(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: const Text('Reset / Clear', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  course.grade = null;
                  _calculateCGPA();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNIMAS Grade Planner'),
        backgroundColor: const Color(0xFF02569B), // UNIMAS Blue-ish tone
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // --- HEADER: CGPA DISPLAY ---
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            width: double.infinity,
            child: Column(
              children: [
                const Text('Current CGPA', style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text(
                  cgpa.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: cgpa >= 3.0 ? Colors.green : Colors.orange,
                  ),
                ),
                Text('Credits Earned: $totalCreditsEarned'),
              ],
            ),
          ),

          // --- BODY: LIST OF SEMESTERS ---
          Expanded(
            child: ListView.builder(
              itemCount: 8, // 4 Years * 2 Semesters = 8 Groups
              itemBuilder: (context, index) {
                // Logic to calculate Year and Sem based on index (0 to 7)
                int year = (index ~/ 2) + 1;
                int sem = (index % 2) + 1;

                // Filter courses for this specific semester
                List<Course> semCourses = courses
                    .where((c) => c.year == year && c.semester == sem)
                    .toList();

                if (semCourses.isEmpty) return const SizedBox();

                return ExpansionTile(
                  initiallyExpanded: year == 1 && sem == 1, // Open first sem by default
                  title: Text(
                    'Year $year Semester $sem',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: semCourses.map((course) {
                    return ListTile(
                      title: Text(course.code, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(course.name),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: course.grade != null ? Colors.blue.shade100 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          course.grade ?? '-',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () => _showGradeDialog(course),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}