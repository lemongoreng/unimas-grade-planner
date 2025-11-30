# 🎓 UNIMAS Grade Planner

A Flutter mobile application designed for **Software Engineering students at Universiti Malaysia Sarawak (UNIMAS)** to track, forecast, and manage their CGPA throughout their 4-year degree program.

## 🚀 About The Project
Calculating CGPA manually is tedious, especially when trying to forecast how a specific grade in one subject affects the overall pointer. This app solves that by pre-loading the entire **Bachelor of Software Engineering** curriculum structure.

Students can simply:
1. Select their current semester.
2. Input their actual or target grades.
3. Instantly see their calculated GPA and CGPA.

## ✨ Key Features
* **Pre-loaded Curriculum:** Contains the full list of subjects (Code, Name, Credit Hours) from Year 1 to Year 4 based on the UNIMAS Software Engineering Guidebook.
* **Real-time Calculation:** Updates the CGPA instantly as grades are modified using the UNIMAS 4.0 grading scale.
* **Semester Organization:** Courses are grouped by Year and Semester using expandable lists for a clean UI.
* **Grading Logic:** accurate mapping of grades (A, A-, B+, etc.) to quality points.

## 🛠️ Tech Stack
* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** [Dart](https://dart.dev/)
* **Architecture:** MVC (Model-View-Controller) pattern with separated data logic.

## 📂 Project Structure
The codebase follows a scalable folder structure:

```text
lib/
├── data/
│   └── unimas_curriculum.dart   # Contains the hardcoded subject list & credit hours
├── models/
│   ├── course.dart              # Data model for Course object
│   └── unimas_grade.dart        # Logic for converting Grades to Points (A = 4.0)
├── screens/
│   └── home_screen.dart         # Main UI with ExpansionTiles and State Management
├── main.dart                    # Entry point
