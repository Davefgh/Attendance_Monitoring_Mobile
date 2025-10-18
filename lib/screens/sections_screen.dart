import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
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
                child: Text(
                  'My Classes',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 20, tablet: 24, desktop: 28),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search, 
                      color: Colors.white, 
                      size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 24, tablet: 28, desktop: 32),
                    ),
                    onPressed: () {
                      // Handle search
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.filter_list, 
                      color: Colors.white, 
                      size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 24, tablet: 28, desktop: 32),
                    ),
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
              padding: ResponsiveUtils.getResponsivePadding(context),
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
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
                                ),
                          ),
                          trailing: Icon(
                            _isBSCSExpanded ? Icons.expand_less : Icons.expand_more,
                            color: const Color(0xFF1E3A8A),
                            size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20, tablet: 24, desktop: 28),
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
                          ..._bscsSubjects.map((subject) => _buildSubjectCard(context, subject)),
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
                      'My Classes',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
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
                      'My Classes',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 16, tablet: 18, desktop: 20),
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
    return SingleChildScrollView(
      padding: ResponsiveUtils.getResponsivePadding(context),
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
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 18, tablet: 20, desktop: 24),
                        ),
                  ),
                  trailing: Icon(
                    _isBSCSExpanded ? Icons.expand_less : Icons.expand_more,
                    color: const Color(0xFF1E3A8A),
                    size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 20, tablet: 24, desktop: 28),
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
                  ..._bscsSubjects.map((subject) => _buildSubjectCard(context, subject)),
                ],
              ],
            ),
          ),
        ],
      ),
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
        // Already on sections
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getResponsiveSpacing(context, mobile: 12, tablet: 16, desktop: 20),
        vertical: ResponsiveUtils.getResponsiveSpacing(context, mobile: 2, tablet: 4, desktop: 6),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: Container(
          width: ResponsiveUtils.getResponsiveSpacing(context, mobile: 32, tablet: 40, desktop: 48),
          height: ResponsiveUtils.getResponsiveSpacing(context, mobile: 32, tablet: 40, desktop: 48),
          decoration: BoxDecoration(
            color: subject['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            subject['icon'],
            color: subject['color'],
            size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
          ),
        ),
        title: Text(
          subject['name'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E3A8A),
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 14, tablet: 16, desktop: 18),
          ),
        ),
        subtitle: Text(
          subject['code'],
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: ResponsiveUtils.getResponsiveFontSize(context, mobile: 10, tablet: 12, desktop: 14),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: const Color(0xFF1E3A8A),
          size: ResponsiveUtils.getResponsiveSpacing(context, mobile: 16, tablet: 20, desktop: 24),
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
