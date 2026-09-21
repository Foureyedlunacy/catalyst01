import 'package:flutter/material.dart';

class ProjectDashboardCard extends StatefulWidget {
  const ProjectDashboardCard({super.key});

  @override
  State<ProjectDashboardCard> createState() => _ProjectDashboardCardState();
}

class _ProjectDashboardCardState extends State<ProjectDashboardCard> {
  // Theme Color Palette
  static const Color colorCream = Color(0xFFF7E4CC);
  static const Color colorDarkTeal = Color(0xFF325453);
  static const Color colorOrange = Color(0xFFF8AD5C);
  static const Color colorRustRed = Color(0xFFB92A0F);

  // Sample Team Members and their Heatmap Accent Colors
  final List<Map<String, dynamic>> teamMembers = [
    {'name': 'Alex (Lead)', 'color': const Color(0xFF325453)},
    {'name': 'Sarah (Dev)', 'color': const Color(0xFFF8AD5C)},
    {'name': 'Mike (Design)', 'color': const Color(0xFFB92A0F)},
  ];

  // Heatmap Data structured by Months
  final List<Map<String, dynamic>> heatmapData = [
    {'month': 'Jul 2026', 'columns': 4},
    {'month': 'Aug 2026', 'columns': 5},
    {'month': 'Sep 2026', 'columns': 4},
    {'month': 'Oct 2026', 'columns': 4},
    {'month': 'Nov 2026', 'columns': 5},
  ];

  // Feature Item Model State
  final List<Map<String, dynamic>> majorFeatures = [
    {
      'title': 'Authentication & Security',
      'status': 'completed',
      'actor': 'Completed by Alex',
      'subFeatures': [
        {'title': 'OAuth2 Integration', 'status': 'completed', 'actor': 'Added by Mike'},
        {'title': 'Two-Factor Auth', 'status': 'completed', 'actor': 'Completed by Alex'},
      ],
    },
    {
      'title': 'Payment Gateway Pipeline',
      'status': 'pending',
      'actor': 'Working on it: Sarah',
      'subFeatures': [
        {'title': 'Stripe API Connect', 'status': 'completed', 'actor': 'Completed by Sarah'},
        {'title': 'Legacy Paypal Fallback', 'status': 'terminated', 'actor': 'Rejected by Alex (Lead)'},
        {'title': 'Invoice PDF Generator', 'status': 'pending', 'actor': 'Working on it: Mike'},
      ],
    },
  ];

  void _toggleStatus(Map<String, dynamic> item) {
    setState(() {
      if (item['status'] == 'completed') {
        item['status'] = 'terminated';
        item['actor'] = 'Rejected by Current User';
      } else if (item['status'] == 'terminated') {
        item['status'] = 'pending';
        item['actor'] = 'Working on it: Current User';
      } else {
        item['status'] = 'completed';
        item['actor'] = 'Completed by Current User';
      }
    });
  }

  void _addMajorFeature() {
    setState(() {
      majorFeatures.add({
        'title': 'New Feature #${majorFeatures.length + 1}',
        'status': 'pending',
        'actor': 'Added by Current User',
        'subFeatures': [
          {'title': 'Initial Sub-task', 'status': 'pending', 'actor': 'Added by Current User'},
        ],
      });
    });
  }

  void _addSubFeature(List subFeatures) {
    setState(() {
      subFeatures.add({
        'title': 'New Sub-task #${subFeatures.length + 1}',
        'status': 'pending',
        'actor': 'Added by Current User',
      });
    });
  }

  Future<void> _searchActivityByDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: colorDarkTeal,
              onPrimary: colorCream,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Loading activity for ${picked.toLocal().toString().split(' ')[0]}..."),
          backgroundColor: colorDarkTeal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorCream,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------------------------------------
          // 1. PROJECT HEADER INTERFACE
          // -----------------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "PROJECT TYPE: SOLO / TEAM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorDarkTeal,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Dashboard Engine",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Central workspace tracking employee activity heatmaps, milestones, and release feature sets.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorRustRed,
                      border: Border.all(color: colorOrange, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    child: const Text(
                      "Public",
                      style: TextStyle(
                        color: colorCream,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_document,
                      color: colorDarkTeal,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.72,
              minHeight: 10,
              color: colorDarkTeal,
              backgroundColor: Colors.white,
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: colorDarkTeal, thickness: 1),
          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // 2. GITHUB-STYLE ACTIVITY HEATMAP CALENDAR
          // -----------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Overall Project Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorDarkTeal,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                tooltip: "Search activity by date",
                onPressed: _searchActivityByDate,
                icon: const Icon(Icons.search, color: colorDarkTeal),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 20, color: colorDarkTeal),
                label: const Text(
                  "Log Activity",
                  style: TextStyle(
                    color: colorDarkTeal,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),

          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorDarkTeal.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: heatmapData.map((monthData) {
                        int colCount = monthData['columns'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0, left: 2.0),
                                child: Text(
                                  monthData['month'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Row(
                                children: List.generate(colCount, (colIndex) {
                                  return Column(
                                    children: List.generate(5, (rowIndex) {
                                      int randomizer = colIndex + rowIndex + monthData['month'].hashCode;
                                      int memberIndex = randomizer % 4;
                                      double intensity = (randomizer % 10) / 10.0;

                                      Color boxColor = Colors.grey.shade200;
                                      if (memberIndex < teamMembers.length && intensity > 0.2) {
                                        Color baseColor = teamMembers[memberIndex]['color'];
                                        boxColor = baseColor.withOpacity(intensity);
                                      }

                                      return Container(
                                        width: 14,
                                        height: 14,
                                        margin: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: boxColor,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: teamMembers.map((member) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: member['color'],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            member['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: colorDarkTeal, thickness: 1),
          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // 3. DEADLINES & CALENDAR SECTION
          // -----------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: const [
                    Icon(Icons.calendar_month, color: colorRustRed),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Upcoming Deadlines",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorDarkTeal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorDarkTeal,
                  foregroundColor: colorCream,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.add_alarm, size: 18),
                label: const Text("Add"),
              )
            ],
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Beta Release 1.0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Due: Sep 30, 2026",
                        style: TextStyle(
                          color: colorRustRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: colorDarkTeal, thickness: 1),
          const SizedBox(height: 16),

          // -----------------------------------------------------------------
          // 4. MAJOR & MINOR SUB-FEATURES MANAGER
          // -----------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Features Checklist",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorDarkTeal,
                  ),
                ),
              ),
              IconButton(
                onPressed: _addMajorFeature,
                icon: const Icon(Icons.add_circle, color: colorOrange, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 8),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: majorFeatures.length,
            itemBuilder: (context, index) {
              final major = majorFeatures[index];
              final List subList = major['subFeatures'];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color.fromARGB(255, 60, 85, 84)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: InkWell(
                            onTap: () => _toggleStatus(major),
                            child: _getStatusIcon(major['status'], size: 24),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                major['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  decoration: major['status'] == 'terminated'
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                major['actor'] ?? 'Assignee pending',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_task, size: 22, color: colorDarkTeal),
                          onPressed: () => _addSubFeature(subList),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 22, color: colorRustRed),
                          onPressed: () {
                            setState(() {
                              majorFeatures.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: subList.map<Widget>((sub) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: InkWell(
                                  onTap: () => _toggleStatus(sub),
                                  child: _getStatusIcon(sub['status'], size: 18),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sub['title'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        decoration: sub['status'] == 'terminated'
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      sub['actor'] ?? 'Assignee pending',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    subList.remove(sub);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getStatusIcon(String status, {double size = 24}) {
    if (status == 'completed') {
      return Icon(Icons.check_circle, color: Colors.green, size: size);
    } else if (status == 'terminated') {
      return Icon(Icons.remove_circle, color: colorRustRed, size: size);
    }
    return Icon(Icons.radio_button_unchecked, color: Colors.grey, size: size);
  }
}