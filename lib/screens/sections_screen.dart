import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'attendance_screen.dart';
import 'qr_screen.dart';
import 'profile_screen.dart';
import 'students_screen.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  bool _isBSCSExpanded = false;

  // Sample subjects for BSCS
  final List<Map<String, dynamic>> _bscsSubjects = [
    {
      'name': 'Computing Fundamentals',
      'code': 'CS11A',
      'icon': Icons.computer,
      'color': Colors.red,
    },
    {
      'name': 'Computer Programming',
      'code': 'CS11A',
      'icon': Icons.code,
      'color': Colors.blue,
    },
    {
      'name': 'Understanding the Self',
      'code': 'CS11A',
      'icon': Icons.psychology,
      'color': Colors.green,
    },
    {
      'name': 'Mathematics',
      'code': 'CS11A',
      'icon': Icons.calculate,
      'color': Colors.orange,
    },
    {
      'name': 'Data Structures',
      'code': 'CS11A',
      'icon': Icons.storage,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Deep blue
              Color(0xFF3B82F6), // Blue
              Color(0xFF60A5FA), // Light blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Logo
                    Image.asset(
                      'images/aclc logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'My Classes',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white, size: 28),
                          onPressed: () {
                            // Handle search
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list, color: Colors.white, size: 28),
                          onPressed: () {
                            // Handle filter
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // BSCS Section Card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Section Header
                              ListTile(
                                title: Text(
                                  'BSCS',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1E3A8A),
                                        fontSize: 20,
                                      ),
                                ),
                                trailing: Icon(
                                  _isBSCSExpanded ? Icons.expand_less : Icons.expand_more,
                                  color: const Color(0xFF1E3A8A),
                                ),
                                onTap: () {
                                  setState(() {
                                    _isBSCSExpanded = !_isBSCSExpanded;
                                  });
                                },
                              ),
                              
                              // Subjects List (Expandable)
                              if (_isBSCSExpanded) ...[
                                const Divider(height: 1),
                                ..._bscsSubjects.map((subject) => _buildSubjectCard(subject)),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF1E3A8A),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: 3, // Sections tab selected
          onTap: (index) {
            if (index == 0) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardScreen()));
            } else if (index == 1) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AttendanceScreen()));
            } else if (index == 2) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QrScreen()));
            } else if (index == 4) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Attendance'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Sections'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: subject['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            subject['icon'],
            color: subject['color'],
            size: 20,
          ),
        ),
        title: Text(
          subject['name'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
        ),
        subtitle: Text(
          subject['code'],
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFF1E3A8A),
        ),
        onTap: () {
          // Navigate to students screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StudentsScreen(
                subjectName: subject['name'],
                subjectCode: subject['code'],
              ),
            ),
          );
        },
      ),
    );
  }
}
