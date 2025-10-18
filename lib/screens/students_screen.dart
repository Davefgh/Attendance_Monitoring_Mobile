import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
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
          child: ResponsiveWidget(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ),
      ),
      bottomNavigationBar: _buildResponsiveBottomNav(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          child: Row(
            children: [
              // Logo
              Image.asset(
                'images/aclc logo.png',
                width: ResponsiveUtils.getResponsiveImageSize(context, mobile: 40, tablet: 50, desktop: 60),
                height: ResponsiveUtils.getResponsiveImageSize(context, mobile: 40, tablet: 50, desktop: 60),
                fit: BoxFit.contain,
              ),
              SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.subjectName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16, tablet: 20, desktop: 24),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.subjectCode,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 24, tablet: 48, desktop: 60)),
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
                  padding: ResponsiveUtils.getResponsivePadding(context),
                  child: Column(
                    children: [
                      // Search Bar
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search students...',
                          prefixIcon: Icon(
                            Icons.search, 
                            color: const Color(0xFF1E3A8A),
                            size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20, tablet: 24, desktop: 28),
                          ),
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
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 12, tablet: 16, desktop: 20),
                            vertical: ResponsiveUtils.getResponsiveSpacing(context, mobile: 12, tablet: 16, desktop: 20),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                      
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
                      
                      // Filter Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['All', 'Present', 'Absent', 'Late'].map((filter) {
                            final isSelected = _selectedFilter == filter;
                            return Container(
                              margin: EdgeInsets.only(right: ResponsiveUtils.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10)),
                              child: FilterChip(
                                label: Text(
                                  filter,
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                                  ),
                                ),
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
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
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
                    padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24)),
                    itemCount: _filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = _filteredStudents[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
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
                            radius: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
                            backgroundColor: _getStatusColor(student['status']).withOpacity(0.1),
                            child: Icon(
                              _getStatusIcon(student['status']),
                              color: _getStatusColor(student['status']),
                              size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
                            ),
                          ),
                          title: Text(
                            student['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E3A8A),
                              fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student['email'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 10, tablet: 12, desktop: 14),
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 2, tablet: 4, desktop: 6)),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10),
                                      vertical: ResponsiveUtils.getResponsiveSpacing(context, mobile: 2, tablet: 4, desktop: 6),
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(student['status']).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      student['status'],
                                      style: TextStyle(
                                        color: _getStatusColor(student['status']),
                                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 8, tablet: 10, desktop: 12),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10)),
                                  Text(
                                    '${student['attendance']}% attendance',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 8, tablet: 10, desktop: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                            size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
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
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        // Left sidebar for navigation
        Container(
          width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 0, tablet: 200, desktop: 250),
          decoration: const BoxDecoration(
            color: Color(0xFF1E3A8A),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: ResponsiveUtils.getResponsivePadding(context),
                child: Column(
                  children: [
                    Image.asset(
                      'images/aclc logo.png',
                      width: ResponsiveUtils.getResponsiveImageSize(context, mobile: 40, tablet: 50, desktop: 60),
                      height: ResponsiveUtils.getResponsiveImageSize(context, mobile: 40, tablet: 50, desktop: 60),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
                    Text(
                      widget.subjectName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.subjectCode,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildSidebarNavigation(context),
              ),
            ],
          ),
        ),
        // Main content
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
            ),
            child: _buildMainContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left sidebar for navigation
        Container(
          width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 0, tablet: 200, desktop: 250),
          decoration: const BoxDecoration(
            color: Color(0xFF1E3A8A),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: ResponsiveUtils.getResponsivePadding(context),
                child: Column(
                  children: [
                    Image.asset(
                      'images/aclc logo.png',
                      width: ResponsiveUtils.getResponsiveImageSize(context, mobile: 40, tablet: 50, desktop: 60),
                      height: ResponsiveUtils.getResponsiveImageSize(context, mobile: 40, tablet: 50, desktop: 60),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
                    Text(
                      widget.subjectName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.subjectCode,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildSidebarNavigation(context),
              ),
            ],
          ),
        ),
        // Main content
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
            ),
            child: _buildMainContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        // Search and Filter Bar
        Padding(
          padding: ResponsiveUtils.getResponsivePadding(context),
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search students...',
                  prefixIcon: Icon(
                    Icons.search, 
                    color: const Color(0xFF1E3A8A),
                    size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20, tablet: 24, desktop: 28),
                  ),
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 12, tablet: 16, desktop: 20),
                    vertical: ResponsiveUtils.getResponsiveSpacing(context, mobile: 12, tablet: 16, desktop: 20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
              
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Present', 'Absent', 'Late'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Container(
                      margin: EdgeInsets.only(right: ResponsiveUtils.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10)),
                      child: FilterChip(
                        label: Text(
                          filter,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
                          ),
                        ),
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
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 12, tablet: 14, desktop: 16),
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
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24)),
            itemCount: _filteredStudents.length,
            itemBuilder: (context, index) {
              final student = _filteredStudents[index];
              return Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16)),
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
                    radius: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
                    backgroundColor: _getStatusColor(student['status']).withOpacity(0.1),
                    child: Icon(
                      _getStatusIcon(student['status']),
                      color: _getStatusColor(student['status']),
                      size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
                    ),
                  ),
                  title: Text(
                    student['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E3A8A),
                      fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['email'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 10, tablet: 12, desktop: 14),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 2, tablet: 4, desktop: 6)),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10),
                              vertical: ResponsiveUtils.getResponsiveSpacing(context, mobile: 2, tablet: 4, desktop: 6),
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(student['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              student['status'],
                              style: TextStyle(
                                color: _getStatusColor(student['status']),
                                fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 8, tablet: 10, desktop: 12),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10)),
                          Text(
                            '${student['attendance']}% attendance',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 8, tablet: 10, desktop: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                    size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
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
    );
  }

  Widget _buildSidebarNavigation(BuildContext context) {
    return Column(
      children: [
        _buildSidebarItem(context, Icons.home, 'Home', 0),
        _buildSidebarItem(context, Icons.assignment, 'Attendance', 1),
        _buildSidebarItem(context, Icons.qr_code, 'QR', 2),
        _buildSidebarItem(context, Icons.groups, 'Sections', 3),
        _buildSidebarItem(context, Icons.person, 'Profile', 4),
      ],
    );
  }

  Widget _buildSidebarItem(BuildContext context, IconData icon, String label, int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 8, tablet: 12, desktop: 16),
        vertical: ResponsiveUtils.getResponsiveSpacing(context, mobile: 4, tablet: 6, desktop: 8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20, tablet: 24, desktop: 28),
        ),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
          ),
        ),
        onTap: () => _handleNavigation(context, index),
      ),
    );
  }

  Widget _buildResponsiveBottomNav(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return Container(
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
          onTap: (index) => _handleNavigation(context, index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Attendance'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Sections'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashboardScreen()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AttendanceScreen()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QrScreen()));
        break;
      case 3:
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SectionsScreen()));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }
}
