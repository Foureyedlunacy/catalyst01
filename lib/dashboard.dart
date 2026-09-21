import 'package:catalyst/homecomponents/h_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette Constants strictly adhering to required colors:
/// #f7e4cc - Warm Cream / Soft Background
/// #325453 - Slate Teal / Primary Accent & Containers
/// #f8ad5c - Warm Amber / Highlights & Icons
/// #b92a0f - Deep Crimson / Alerts & Actions
/// Colors.black & Colors.white
class AppColors {
  static const Color cream = Color(0xFFF7E4CC);
  static const Color slateTeal = Color(0xFF325453);
  static const Color amber = Color(0xFFF8AD5C);
  static const Color crimson = Color(0xFFB92A0F);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
}

// -----------------------------------------------------------------------------
// Data Models
// -----------------------------------------------------------------------------

enum TeamRelationType { requestsSent, joinedTeams, myTeams }

class TeamOverviewItem {
  final String id;
  final String teamName;
  final String date;
  final String statusOrRole;
  final TeamRelationType type;

  TeamOverviewItem({
    required this.id,
    required this.teamName,
    required this.date,
    required this.statusOrRole,
    required this.type,
  });
}

class TeamMessage {
  final String id;
  final String teamName;
  final String memberName;
  final String date;
  final String shortSnippet;
  final String fullMessage;
  bool isRead;
  bool isBlocked;

  TeamMessage({
    required this.id,
    required this.teamName,
    required this.memberName,
    required this.date,
    required this.shortSnippet,
    required this.fullMessage,
    this.isRead = false,
    this.isBlocked = false,
  });
}

class TeamProjectCardData {
  final String id;
  final String teamName;
  final String pitchIdea;
  final int currentMembers;
  final int totalMembersNeeded;
  final String timeCreatedAgo;
  final List<String> requiredSkills;

  TeamProjectCardData({
    required this.id,
    required this.teamName,
    required this.pitchIdea,
    required this.currentMembers,
    required this.totalMembersNeeded,
    required this.timeCreatedAgo,
    required this.requiredSkills,
  });
}

// -----------------------------------------------------------------------------
// Base dashboard Page Layout
// -----------------------------------------------------------------------------

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 60, 0),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  minimumSize: const Size(1, 1),
                  maximumSize: const Size(32, 32),
                ),
                child: const Icon(Icons.menu, size: 30, color: AppColors.amber),
              ),
              const SizedBox(width: 30),
              Text(
                "Catalyst",
                style: GoogleFonts.anta(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: AppColors.amber,
                ),
              ),
              const Expanded(child: SizedBox()),
              const Text(
                'Dashboard',
                style: TextStyle(color: AppColors.amber),
              ),
              const SizedBox(width: 30),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.slateTeal,
                  foregroundColor: AppColors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: AppColors.amber, width: 3),
                  ),
                ),
                onPressed: () {},
                child: const Text("SIGNIN/UP"),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.slateTeal,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Hnavbar(),
          // Embedded Dashboard Content
          Expanded(
            child: DashboardContentWidget(),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Dashboard Content Widget
// -----------------------------------------------------------------------------

class DashboardContentWidget extends StatefulWidget {
  const DashboardContentWidget({Key? key}) : super(key: key);

  @override
  State<DashboardContentWidget> createState() => _DashboardContentWidgetState();
}

class _DashboardContentWidgetState extends State<DashboardContentWidget> {
  // Top Left Tab state
  TeamRelationType _selectedOverviewTab = TeamRelationType.requestsSent;

  // Search & Filter state
  String _searchQuery = '';
  final Set<String> _selectedSkills = {};

  // Mock Data: Team Overview Items
  final List<TeamOverviewItem> _overviewItems = [
    TeamOverviewItem(
      id: '1',
      teamName: 'CyberShield AI',
      date: 'Sep 20, 2026',
      statusOrRole: 'Pending Approval',
      type: TeamRelationType.requestsSent,
    ),
    TeamOverviewItem(
      id: '2',
      teamName: 'GreenTech Logistics',
      date: 'Sep 18, 2026',
      statusOrRole: 'Under Review',
      type: TeamRelationType.requestsSent,
    ),
    TeamOverviewItem(
      id: '3',
      teamName: 'FinPulse Dashboard',
      date: 'Aug 14, 2026',
      statusOrRole: 'Frontend Dev',
      type: TeamRelationType.joinedTeams,
    ),
    TeamOverviewItem(
      id: '4',
      teamName: 'HealthSync App',
      date: 'Jul 02, 2026',
      statusOrRole: 'UI/UX Lead',
      type: TeamRelationType.joinedTeams,
    ),
    TeamOverviewItem(
      id: '5',
      teamName: 'NeuralVision Analytics',
      date: 'Jan 10, 2026',
      statusOrRole: 'Founder / Lead',
      type: TeamRelationType.myTeams,
    ),
    TeamOverviewItem(
      id: '6',
      teamName: 'DevFlow Automations',
      date: 'May 22, 2026',
      statusOrRole: 'Owner',
      type: TeamRelationType.myTeams,
    ),
  ];

  // Mock Data: Messages / Notifications
  final List<TeamMessage> _messages = [
    TeamMessage(
      id: 'm1',
      teamName: 'NeuralVision Analytics',
      memberName: 'Sarah Connor',
      date: '20 Sep, 14:30',
      shortSnippet: 'Hey! The computer vision pipeline is ready for review...',
      fullMessage:
          'Hey! The computer vision pipeline is ready for review. I uploaded the initial benchmark results to our repo. Let me know when you want to schedule the design sprint sync.',
    ),
    TeamMessage(
      id: 'm2',
      teamName: 'FinPulse Dashboard',
      memberName: 'Alex Rivera',
      date: '19 Sep, 09:15',
      shortSnippet: 'Updated the Flutter charts theme to match brand specs.',
      fullMessage:
          'Updated the Flutter charts theme to match brand specs. Please review the PR #42 when you get a chance. All unit tests for stock indicators passed.',
    ),
    TeamMessage(
      id: 'm3',
      teamName: 'HealthSync App',
      memberName: 'Dr. Liam Vance',
      date: '15 Sep, 18:45',
      shortSnippet: 'Can we check HIPAA compliance on the user sync endpoint?',
      fullMessage:
          'Can we check HIPAA compliance on the user sync endpoint? Our backend auditor requested the logs from last night\'s batch update. Thanks!',
    ),
  ];

  // Available skills filter list
  final List<String> _availableSkills = [
    'Flutter',
    'Dart',
    'UI/UX',
    'Node.js',
    'Python',
    'Firebase',
    'Machine Learning',
  ];

  // Mock Data: Teams / Projects
  final List<TeamProjectCardData> _teamProjects = [
    TeamProjectCardData(
      id: 'p1',
      teamName: 'EcoTrack IoT',
      pitchIdea:
          'Smart carbon footprint monitoring dashboard using embedded microcontrollers and live Flutter telemetry visualization.',
      currentMembers: 3,
      totalMembersNeeded: 5,
      timeCreatedAgo: 'Created 2 days ago',
      requiredSkills: ['Flutter', 'Python', 'Firebase'],
    ),
    TeamProjectCardData(
      id: 'p2',
      teamName: 'CodeLoom AI',
      pitchIdea:
          'Collaborative IDE extension delivering context-aware snippet recommendations and inline code refactoring.',
      currentMembers: 4,
      totalMembersNeeded: 6,
      timeCreatedAgo: 'Created 5 days ago',
      requiredSkills: ['Node.js', 'Machine Learning', 'Dart'],
    ),
    TeamProjectCardData(
      id: 'p3',
      teamName: 'Zenith Studio Design',
      pitchIdea:
          'Design system library and cross-platform UI engine for high-performance mobile e-commerce platforms.',
      currentMembers: 2,
      totalMembersNeeded: 4,
      timeCreatedAgo: 'Created 1 week ago',
      requiredSkills: ['UI/UX', 'Flutter'],
    ),
    TeamProjectCardData(
      id: 'p4',
      teamName: 'MediBot Companion',
      pitchIdea:
          'AI-driven health assistant providing automated pill reminders and real-time biometric anomaly alerts.',
      currentMembers: 5,
      totalMembersNeeded: 5,
      timeCreatedAgo: 'Created 2 weeks ago',
      requiredSkills: ['Python', 'Machine Learning', 'Flutter'],
    ),
  ];

  // Filter logic for bottom half team cards
  List<TeamProjectCardData> get _filteredTeams {
    return _teamProjects.where((team) {
      final matchesSearch = team.teamName
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          team.pitchIdea.toLowerCase().contains(_searchQuery.toLowerCase());

      if (_selectedSkills.isEmpty) return matchesSearch;

      final matchesSkills = _selectedSkills.every(
        (skill) => team.requiredSkills.contains(skill),
      );

      return matchesSearch && matchesSkills;
    }).toList();
  }

  // Action: Read All
  void _markAllAsRead() {
    setState(() {
      for (var msg in _messages) {
        msg.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'All messages marked as read.',
          style: TextStyle(color: AppColors.cream),
        ),
        backgroundColor: AppColors.slateTeal,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Action: Block Member
  void _toggleBlockMember(TeamMessage msg) {
    setState(() {
      msg.isBlocked = !msg.isBlocked;
    });
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg.isBlocked
              ? 'Blocked notifications from ${msg.memberName}.'
              : 'Unblocked ${msg.memberName}.',
          style: const TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.crimson,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Detail Modal Dialog for Message
  void _showMessageDetailDialog(TeamMessage msg) {
    setState(() {
      msg.isRead = true;
    });

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: AppColors.slateTeal, width: 2),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.slateTeal,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            msg.teamName,
                            style: const TextStyle(
                              color: AppColors.cream,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          msg.memberName,
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    msg.date,
                    style: const TextStyle(
                      color: AppColors.slateTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: AppColors.amber, thickness: 1.5),
              ),
              Text(
                msg.fullMessage,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _toggleBlockMember(msg),
                    icon: Icon(
                      msg.isBlocked ? Icons.check_circle : Icons.block,
                      size: 16,
                      color: AppColors.crimson,
                    ),
                    label: Text(
                      msg.isBlocked ? 'Unblock Member' : 'Block Member',
                      style: const TextStyle(
                        color: AppColors.crimson,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.crimson),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.slateTeal,
                      foregroundColor: AppColors.cream,
                    ),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Team Management & Discovery Hub',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.slateTeal,
              ),
            ),
            const SizedBox(height: 16),

            // ===============================================================
            // TOP HALF: Split Panels (Teams Status Left | Notifications Right)
            // ===============================================================
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                return isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 6, child: _buildTeamsOverviewPanel()),
                          const SizedBox(width: 16),
                          Expanded(flex: 5, child: _buildNotificationsPanel()),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTeamsOverviewPanel(),
                          const SizedBox(height: 16),
                          _buildNotificationsPanel(),
                        ],
                      );
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(color: AppColors.amber, thickness: 2),
            ),

            // ===============================================================
            // BOTTOM HALF: Search, Skill Filters & Team Box Cards
            // ===============================================================
            _buildBottomSearchAndDiscoverySection(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Left Panel: Requests Sent / Joined Teams / My Teams
  // ---------------------------------------------------------------------------
  Widget _buildTeamsOverviewPanel() {
    final filteredOverview = _overviewItems
        .where((item) => item.type == _selectedOverviewTab)
        .toList();

    return Container(
      height: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slateTeal.withOpacity(0.3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Teams Overview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.slateTeal,
            ),
          ),
          const SizedBox(height: 12),
          // Tab Switchers
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTabChip(
                  label: 'Requests Sent',
                  type: TeamRelationType.requestsSent,
                ),
                const SizedBox(width: 8),
                _buildTabChip(
                  label: 'Joined Teams',
                  type: TeamRelationType.joinedTeams,
                ),
                const SizedBox(width: 8),
                _buildTabChip(
                  label: 'My Teams',
                  type: TeamRelationType.myTeams,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // List View
          Expanded(
            child: filteredOverview.isEmpty
                ? const Center(
                    child: Text(
                      'No items under this category.',
                      style: TextStyle(color: AppColors.black),
                    ),
                  )
                : ListView.separated(
                    itemCount: filteredOverview.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.cream),
                    itemBuilder: (context, index) {
                      final item = filteredOverview[index];
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.amber.withOpacity(0.3),
                          child: const Icon(
                            Icons.groups,
                            color: AppColors.slateTeal,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          item.teamName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        subtitle: Text(
                          'Date: ${item.date}',
                          style: const TextStyle(
                            color: AppColors.slateTeal,
                            fontSize: 11,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.amber),
                          ),
                          child: Text(
                            item.statusOrRole,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.crimson,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabChip({
    required String label,
    required TeamRelationType type,
  }) {
    final isSelected = _selectedOverviewTab == type;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.slateTeal,
      backgroundColor: AppColors.cream,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.cream : AppColors.slateTeal,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onSelected: (_) {
        setState(() {
          _selectedOverviewTab = type;
        });
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Top Right Panel: Notifications / Member Messages
  // ---------------------------------------------------------------------------
  Widget _buildNotificationsPanel() {
    final activeMessages =
        _messages.where((m) => !m.isBlocked).toList();

    return Container(
      height: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slateTeal.withOpacity(0.3), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Notifications & Messages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.slateTeal,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${activeMessages.where((m) => !m.isRead).length}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  )
                ],
              ),
              TextButton(
                onPressed: _markAllAsRead,
                child: const Text(
                  'Read All',
                  style: TextStyle(
                    color: AppColors.crimson,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: activeMessages.isEmpty
                ? const Center(
                    child: Text(
                      'No active messages.',
                      style: TextStyle(color: AppColors.black),
                    ),
                  )
                : ListView.separated(
                    itemCount: activeMessages.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 8, color: AppColors.cream),
                    itemBuilder: (context, index) {
                      final msg = activeMessages[index];
                      return InkWell(
                        onTap: () => _showMessageDetailDialog(msg),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: msg.isRead
                                ? AppColors.cream.withOpacity(0.3)
                                : AppColors.cream,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: msg.isRead
                                  ? Colors.transparent
                                  : AppColors.amber,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${msg.teamName} • ${msg.memberName}',
                                      style: TextStyle(
                                        fontWeight: msg.isRead
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                        color: AppColors.slateTeal,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    msg.date,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg.shortSnippet,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Half: Search Teams, Skill Filters & Box Cards
  // ---------------------------------------------------------------------------
  Widget _buildBottomSearchAndDiscoverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Discover & Join Teams',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.slateTeal,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.slateTeal.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by team name or project idea...',
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.slateTeal),
                  filled: true,
                  fillColor: AppColors.cream,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                'Filter by required skills:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.slateTeal,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _availableSkills.map((skill) {
                  final isSelected = _selectedSkills.contains(skill);
                  return FilterChip(
                    label: Text(skill),
                    selected: isSelected,
                    selectedColor: AppColors.amber,
                    backgroundColor: AppColors.cream,
                    checkmarkColor: AppColors.black,
                    labelStyle: TextStyle(
                      color: AppColors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 11,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedSkills.add(skill);
                        } else {
                          _selectedSkills.remove(skill);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _filteredTeams.isEmpty
            ? Container(
                padding: const EdgeInsets.all(32),
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'No teams match your search or selected skill criteria.',
                  style: TextStyle(color: AppColors.slateTeal),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 360,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _filteredTeams.length,
                itemBuilder: (context, index) {
                  final project = _filteredTeams[index];
                  return _buildBoxTeamCard(project);
                },
              ),
      ],
    );
  }

  // Box-shaped Team Card Component
  Widget _buildBoxTeamCard(TeamProjectCardData project) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slateTeal, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.teamName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slateTeal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      project.timeCreatedAgo,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                project.pitchIdea,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.black,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: project.requiredSkills.map((sk) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      sk,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          Column(
            children: [
              const Divider(color: AppColors.cream, thickness: 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person,
                          size: 16, color: AppColors.slateTeal),
                      const SizedBox(width: 4),
                      Text(
                        '${project.currentMembers}/${project.totalMembersNeeded} Members',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.slateTeal,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Request sent to join ${project.teamName}!',
                            style: const TextStyle(color: AppColors.cream),
                          ),
                          backgroundColor: AppColors.slateTeal,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.crimson,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}