import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubWidget extends StatefulWidget {
  const GithubWidget({super.key});

  @override
  State<GithubWidget> createState() => _GithubWidgetState();
}

class _GithubWidgetState extends State<GithubWidget> {
  // -------------------------------------------------------------
  // REPOSITORY CONFIGURATION
  // -------------------------------------------------------------
  final String repoName = "catalyst-mobile-app";
  final String repoOwner = "catalyst-devs";
  final String repoUrl = "https://github.com/catalyst-devs/catalyst-mobile-app";

  // -------------------------------------------------------------
  // EXACT COLOR PALETTE
  // -------------------------------------------------------------
  static const Color colorCream = Color(0xFFF7E4CC);
  static const Color colorTeal = Color(0xFF325453);
  static const Color colorOrange = Color(0xFFF8AD5C);
  static const Color colorRed = Color(0xFFB92A0F);
  static const Color colorBlack = Colors.black;
  static const Color colorWhite = Colors.white;

  // -------------------------------------------------------------
  // COMMIT HISTORY DATA
  // -------------------------------------------------------------
  final List<Map<String, dynamic>> _commits = [
    {
      "message": "Feat: Add dynamic theme switching and sidebar widget switching",
      "hash": "7a3f89b",
      "date": "Sep 21, 2026",
      "time": "18:42",
      "isAccepted": true,
    },
    {
      "message": "Refactor: Update navigation router and profile links",
      "hash": "3c91a02",
      "date": "Sep 20, 2026",
      "time": "14:15",
      "isAccepted": true,
    },
    {
      "message": "Fix: Temporary direct database connection credentials inside config",
      "hash": "b182c4f",
      "date": "Sep 19, 2026",
      "time": "11:05",
      "isAccepted": false, // Rejected commit
      "rejectionReason": "Security issue: Hardcoded keys detected in code."
    },
    {
      "message": "Design: Responsive layout adjustments for dashboard widgets",
      "hash": "9d4e510",
      "date": "Sep 18, 2026",
      "time": "09:30",
      "isAccepted": true,
    },
    {
      "message": "Chore: Large unformatted dependencies bundle update",
      "hash": "f45a19c",
      "date": "Sep 16, 2026",
      "time": "16:20",
      "isAccepted": false, // Rejected commit
      "rejectionReason": "PR too large. Please break it into smaller commits."
    },
  ];

  // Helper function to open GitHub URL in browser
  Future<void> _openGitHubRepo() async {
    final Uri url = Uri.parse(repoUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalAccepted = _commits.where((c) => c['isAccepted'] == true).length;
    int totalRejected = _commits.where((c) => c['isAccepted'] == false).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // =========================================================
        // TOP SECTION: REPO HEADER & VISIT BUTTON
        // =========================================================
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorTeal,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorOrange, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, color: colorCream, size: 16),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "Owner: $repoOwner",
                                style: const TextStyle(
                                  color: colorCream,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          repoName,
                          style: const TextStyle(
                            color: colorOrange,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Open Repo Button
                  ElevatedButton.icon(
                    onPressed: _openGitHubRepo,
                    icon: const Icon(Icons.open_in_new, size: 16, color: colorBlack),
                    label: const Text(
                      "Open Repo",
                      style: TextStyle(
                        color: colorBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(color: colorOrange, thickness: 0.5),
              const SizedBox(height: 12),

              // Summary Stats Row
              Row(
                children: [
                  _buildStatCard("Total Commits", "${_commits.length}", colorBlack, colorCream),
                  const SizedBox(width: 8),
                  _buildStatCard("Accepted", "$totalAccepted", colorTeal, colorWhite),
                  const SizedBox(width: 8),
                  _buildStatCard("Rejected", "$totalRejected", colorCream, colorRed),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // =========================================================
        // BOTTOM SECTION: COMMIT HISTORY LIST
        // =========================================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Push & Commit History",
              style: TextStyle(
                color: colorOrange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.history, color: colorCream, size: 20),
          ],
        ),
        const SizedBox(height: 12),

        // Non-overflowing, auto-sizing list within parent scrollview
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _commits.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final commit = _commits[index];
            final bool isAccepted = commit['isAccepted'];

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorTeal,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isAccepted ? colorOrange : colorRed,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Commit Hash & Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.commit, color: colorCream, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "#${commit['hash']}",
                            style: const TextStyle(
                              color: colorCream,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                      // Status Badge (Accepted/Rejected)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isAccepted ? colorWhite : colorRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isAccepted ? Icons.check_circle : Icons.cancel,
                              size: 13,
                              color: isAccepted ? colorTeal : colorWhite,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isAccepted ? "Accepted" : "Rejected",
                              style: TextStyle(
                                color: isAccepted ? colorTeal : colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Commit Message Text
                  Text(
                    commit['message'],
                    style: const TextStyle(
                      color: colorCream,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Rejection Reason Box (if rejected)
                  if (!isAccepted && commit['rejectionReason'] != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorRed,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Reason: ${commit['rejectionReason']}",
                        style: const TextStyle(
                          color: colorCream,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),
                  const Divider(color: colorCream, thickness: 0.3),
                  const SizedBox(height: 6),

                  // Bottom Row: Date & Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.access_time, color: colorOrange, size: 13),
                      const SizedBox(width: 4),
                      Text(
                        "${commit['date']} at ${commit['time']}",
                        style: const TextStyle(
                          color: colorOrange,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Stat Card Builder Helper
  Widget _buildStatCard(String label, String value, Color textColor, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: colorOrange, width: 1),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}