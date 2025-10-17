import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedSort = 'all'; // Default: show all students
  bool showSortMenu = false;
  bool isHovering = false;
  List<StudentAttendance> attendanceList = [
    StudentAttendance(name: 'John Doe', studentId: '2024-001', status: 'present', time: '08:30 AM'),
    StudentAttendance(name: 'Jane Smith', studentId: '2024-002', status: 'late', time: '09:15 AM'),
    StudentAttendance(name: 'Mike Johnson', studentId: '2024-003', status: 'absent', time: '--'),
    StudentAttendance(name: 'Sarah Wilson', studentId: '2024-004', status: 'present', time: '08:35 AM'),
    StudentAttendance(name: 'David Brown', studentId: '2024-005', status: 'late', time: '09:20 AM'),
    StudentAttendance(name: 'Emily Davis', studentId: '2024-006', status: 'absent', time: '--'),
    StudentAttendance(name: 'Chris Miller', studentId: '2024-007', status: 'present', time: '08:40 AM'),
    StudentAttendance(name: 'Lisa Garcia', studentId: '2024-008', status: 'present', time: '08:25 AM'),
    StudentAttendance(name: 'Tom Anderson', studentId: '2024-009', status: 'absent', time: '--'),
    StudentAttendance(name: 'Amy Taylor', studentId: '2024-010', status: 'late', time: '09:10 AM'),
    StudentAttendance(name: 'Ryan Lee', studentId: '2024-011', status: 'present', time: '08:45 AM'),
    StudentAttendance(name: 'Maya Patel', studentId: '2024-012', status: 'late', time: '09:05 AM'),
  ];

  int get presentCount => attendanceList.where((s) => s.status == 'present').length;
  int get absentCount => attendanceList.where((s) => s.status == 'absent').length;
  int get lateCount => attendanceList.where((s) => s.status == 'late').length;

  List<StudentAttendance> get filteredAttendanceList {
    if (selectedSort == 'all') {
      return attendanceList;
    } else {
      return attendanceList.where((student) => student.status == selectedSort).toList();
    }
  }

  void selectSort(String status) {
    setState(() {
      selectedSort = status;
      showSortMenu = false;
    });
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
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // ACLC Logo
                    Image.asset(
                      'images/aclc logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    // Attendance Title
                    Expanded(
                      child: Text(
                        'Attendance',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    // Notification Bell
                    const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
              ),
              
              // Main Content
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status Cards
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatusCard(
                                'Present',
                                presentCount.toString(),
                                Icons.check_circle,
                                const Color(0xFF10B981),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatusCard(
                                'Late',
                                lateCount.toString(),
                                Icons.schedule,
                                const Color(0xFFF59E0B),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatusCard(
                                'Absent',
                                absentCount.toString(),
                                Icons.cancel,
                                const Color(0xFFEF4444),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Sort Section
                        Row(
                          children: [
                            Text(
                              'Attendance List',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E3A8A),
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            // Expandable Sort Icon
                            _buildExpandableSortIcon(),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Attendance List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredAttendanceList.length,
                          itemBuilder: (context, index) {
                            final student = filteredAttendanceList[index];
                            return _buildStudentCard(student);
                          },
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
          currentIndex: 1, // Attendance tab selected
          onTap: (index) {
            if (index == 0) {
              Navigator.of(context).pop(); // Go back to dashboard
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'QR',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Sections',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              count,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(StudentAttendance student) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getStatusColor(student.status).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Status Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getStatusColor(student.status).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getStatusIcon(student.status),
              color: _getStatusColor(student.status),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Student Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  student.studentId,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Time/Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                student.time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: _getStatusColor(student.status),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(student.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  student.status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(student.status),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSortIcon() {
    return Stack(
      children: [
        // Main All Students Icon
        GestureDetector(
          onTap: () => selectSort('all'),
          onTapDown: (_) => setState(() => isHovering = true),
          onTapUp: (_) => setState(() => isHovering = false),
          onTapCancel: () => setState(() => isHovering = false),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedSort == 'all' ? const Color(0xFF1E3A8A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: selectedSort == 'all' ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
                width: selectedSort == 'all' ? 2 : 1,
              ),
            ),
            child: Icon(
              Icons.people_alt,
              color: selectedSort == 'all' ? Colors.white : Colors.grey[600],
              size: 24,
            ),
          ),
        ),
        
        // Expanded Sort Options (shown when hovering)
        if (isHovering)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildExpandedSortOption('present', Icons.check_circle),
                  const SizedBox(height: 8),
                  _buildExpandedSortOption('late', Icons.schedule),
                  const SizedBox(height: 8),
                  _buildExpandedSortOption('absent', Icons.cancel),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpandedSortOption(String status, IconData icon) {
    return GestureDetector(
      onTap: () => selectSort(status),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selectedSort == status ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selectedSort == status ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
            width: selectedSort == status ? 2 : 1,
          ),
        ),
        child: Icon(
          icon,
          color: selectedSort == status ? Colors.white : Colors.grey[600],
          size: 20,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'present':
        return const Color(0xFF10B981);
      case 'late':
        return const Color(0xFFF59E0B);
      case 'absent':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'present':
        return Icons.check_circle;
      case 'late':
        return Icons.schedule;
      case 'absent':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}

class StudentAttendance {
  final String name;
  final String studentId;
  final String status;
  final String time;

  StudentAttendance({
    required this.name,
    required this.studentId,
    required this.status,
    required this.time,
  });
}
