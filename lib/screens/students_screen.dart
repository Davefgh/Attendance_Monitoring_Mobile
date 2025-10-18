import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'attendance_screen.dart';
import 'qr_screen.dart';
import 'profile_screen.dart';
import 'sections_screen.dart';

class StudentsScreen extends StatefulWidget {
  final String subjectName;
  final String subjectCode;

  const StudentsScreen({
    super.key,
    required this.subjectName,
    required this.subjectCode,
  });

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  // Sample students data
  final List<Map<String, dynamic>> _students = [
    {
      'id': '001',
      'name': 'John Doe',
      'email': 'john.doe@student.com',
      'status': 'Present',
      'attendance': 95,
    },
    {
      'id': '002',
      'name': 'Jane Smith',
      'email': 'jane.smith@student.com',
      'status': 'Present',
      'attendance': 88,
    },
    {
      'id': '003',
      'name': 'Mike Johnson',
      'email': 'mike.johnson@student.com',
      'status': 'Absent',
      'attendance': 75,
    },
    {
      'id': '004',
      'name': 'Sarah Wilson',
      'email': 'sarah.wilson@student.com',
      'status': 'Present',
      'attendance': 92,
    },
    {
      'id': '005',
      'name': 'David Brown',
      'email': 'david.brown@student.com',
      'status': 'Late',
      'attendance': 80,
    },
    {
      'id': '006',
      'name': 'Emily Davis',
      'email': 'emily.davis@student.com',
      'status': 'Present',
      'attendance': 90,
    },
  ];

  List<Map<String, dynamic>> get _filteredStudents {
    List<Map<String, dynamic>> filtered = _students;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((student) =>
          student['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          student['email'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          student['id'].contains(_searchQuery)).toList();
    }

    // Filter by status
    if (_selectedFilter != 'All') {
      filtered = filtered.where((student) => student['status'] == _selectedFilter).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Present':
        return Icons.check_circle;
      case 'Absent':
        return Icons.cancel;
      case 'Late':
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }

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
                      child: Column(
                        children: [
                          Text(
                            widget.subjectName,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.subjectCode,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the layout
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
                  child: Column(
                    children: [
                      // Search and Filter Bar
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Search Bar
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Search students...',
                                prefixIcon: const Icon(Icons.search, color: Color(0xFF1E3A8A)),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Filter Chips
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: ['All', 'Present', 'Absent', 'Late'].map((filter) {
                                  final isSelected = _selectedFilter == filter;
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      label: Text(filter),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        setState(() {
                                          _selectedFilter = filter;
                                        });
                                      },
                                      selectedColor: const Color(0xFF1E3A8A).withOpacity(0.2),
                                      checkmarkColor: const Color(0xFF1E3A8A),
                                      labelStyle: TextStyle(
                                        color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[600],
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Students List
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = _filteredStudents[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: _getStatusColor(student['status']).withOpacity(0.1),
                                  child: Icon(
                                    _getStatusIcon(student['status']),
                                    color: _getStatusColor(student['status']),
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  student['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student['email'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(student['status']).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            student['status'],
                                            style: TextStyle(
                                              color: _getStatusColor(student['status']),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${student['attendance']}% attendance',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey[400],
                                ),
                                onTap: () {
                                  // Handle student tap - could show student details
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Selected ${student['name']}'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
            } else if (index == 3) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SectionsScreen()));
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
}
