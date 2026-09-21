import 'package:flutter/material.dart';

// --- Data Models ---
class ResearchPlatform {
  final String id;
  final String name;
  final String category;
  final String description;
  final IconData icon;
  final Color brandColor;

  ResearchPlatform({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.icon,
    required this.brandColor,
  });
}

class ResearchHistoryItem {
  final String id;
  final String title;
  final String platformName;
  final String type; // 'Chat', 'File', 'Query'
  final String dateTime;

  ResearchHistoryItem({
    required this.id,
    required this.title,
    required this.platformName,
    required this.type,
    required this.dateTime,
  });
}

// --- Main Widget ---
class ResearchWidget extends StatefulWidget {
  const ResearchWidget({super.key});

  @override
  State<ResearchWidget> createState() => _ResearchWidgetState();
}

class _ResearchWidgetState extends State<ResearchWidget> {
  // Theme colors
  final Color _panelBg = const Color(0xFF325453);
  final Color _accent = const Color(0xFFF8AD5C);
  final Color _bg = const Color(0xFF243B3A);

  // --- Mock Data: AI Models & Platforms ---
  final List<ResearchPlatform> _platforms = [
    ResearchPlatform(
      id: "1",
      name: "Google Gemini",
      category: "LLM / Multimodal",
      description: "Advanced reasoning, oceanography data analysis, and code generation.",
      icon: Icons.auto_awesome,
      brandColor: const Color(0xFF4285F4),
    ),
    ResearchPlatform(
      id: "2",
      name: "ChatGPT (OpenAI)",
      category: "LLM / Assistant",
      description: "Deep data parsing, system architecture review, and text drafting.",
      icon: Icons.chat_bubble_outline,
      brandColor: const Color(0xFF10A37F),
    ),
    ResearchPlatform(
      id: "3",
      name: "Hugging Face",
      category: "Model Repository",
      description: "Open-source ocean sensor telemetry models and transformers.",
      icon: Icons.emoji_objects_outlined,
      brandColor: const Color(0xFFFFD21E),
    ),
    ResearchPlatform(
      id: "4",
      name: "arXiv Papers",
      category: "Scientific Research",
      description: "Access latest marine biology, IoT buoys, and fluid dynamics journals.",
      icon: Icons.menu_book,
      brandColor: const Color(0xFFB31B1B),
    ),
    ResearchPlatform(
      id: "5",
      name: "Claude (Anthropic)",
      category: "LLM / Analysis",
      description: "Long-context document analysis and comprehensive debugging support.",
      icon: Icons.psychology,
      brandColor: const Color(0xFFCC9966),
    ),
    ResearchPlatform(
      id: "6",
      name: "GitHub Copilot",
      category: "AI Coding Assistant",
      description: "Inline repository code autocompletion and syntax optimization.",
      icon: Icons.code,
      brandColor: const Color(0xFF6E5494),
    ),
  ];

  // --- Mock Data: History Logs ---
  final List<ResearchHistoryItem> _history = [
    ResearchHistoryItem(
      id: "h1",
      title: "Varun Ocean Sensor Salinity Threshold Analysis",
      platformName: "Google Gemini",
      type: "Chat",
      dateTime: "2026-09-21 09:30 AM",
    ),
    ResearchHistoryItem(
      id: "h2",
      title: "Deep_Sea_Telemetry_Buffer_Draft.pdf",
      platformName: "Hugging Face",
      type: "File",
      dateTime: "2026-09-20 04:15 PM",
    ),
    ResearchHistoryItem(
      id: "h3",
      title: "FastAPI + Vite Asynchronous Socket Optimization",
      platformName: "ChatGPT (OpenAI)",
      type: "Query",
      dateTime: "2026-09-19 02:10 PM",
    ),
    ResearchHistoryItem(
      id: "h4",
      title: "Buoy Array Energy Consumption Benchmark Review",
      platformName: "arXiv Papers",
      type: "Chat",
      dateTime: "2026-09-18 11:00 AM",
    ),
  ];

  // --- Actions ---
  void _openPlatform(ResearchPlatform platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Launching research session with ${platform.name}...', style: const TextStyle(color: Colors.black)),
        backgroundColor: _accent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _uploadDocument() {
    // Simulate file upload dialog / action
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _panelBg,
        title: const Text("Upload Research Document", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Select a PDF, text, or dataset file to add to your Varun Ocean Monitoring research repository.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _accent, foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _history.insert(0, ResearchHistoryItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: "Varun_Telemetry_Spec_v2.pdf",
                  platformName: "Google Gemini",
                  type: "File",
                  dateTime: "2026-09-21 11:59 PM",
                ));
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Document uploaded successfully!"), backgroundColor: Colors.green),
              );
            },
            child: const Text("Upload File", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _addNewPlatform() {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _panelBg,
        title: const Text("Add Custom Platform / Model", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Platform / Model Name", labelStyle: TextStyle(color: Colors.white70)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Short Description", labelStyle: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _accent, foregroundColor: Colors.black),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() {
                  _platforms.add(ResearchPlatform(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameCtrl.text,
                    category: "Custom Tool",
                    description: descCtrl.text.isNotEmpty ? descCtrl.text : "Custom added research tool.",
                    icon: Icons.extension,
                    brandColor: Colors.purpleAccent,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add Platform", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _removePlatform(String id) {
    setState(() {
      _platforms.removeWhere((p) => p.id == id);
    });
  }

  void _removeHistoryItem(String id) {
    setState(() {
      _history.removeWhere((h) => h.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ==========================================
        // TOP SECTION: AVAILABLE AI MODELS & PLATFORMS
        // ==========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "AI Models & Research Platforms",
              style: TextStyle(color: Color(0xFFF8AD5C), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.black,
              ),
              onPressed: _addNewPlatform,
              icon: const Icon(Icons.add, size: 18),
              label: const Text("Add Platform", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Grid of Platforms
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.3,
          ),
          itemCount: _platforms.length,
          itemBuilder: (context, index) {
            final platform = _platforms[index];
            return Container(
              decoration: BoxDecoration(
                color: _panelBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: platform.brandColor.withOpacity(0.4), width: 1.5),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _openPlatform(platform),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: platform.brandColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(platform.icon, color: platform.brandColor, size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      platform.name,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => _removePlatform(platform.id),
                                    child: const Icon(Icons.close, color: Colors.white38, size: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                platform.category,
                                style: TextStyle(color: platform.brandColor, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                platform.description,
                                style: const TextStyle(color: Colors.white60, fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 35),

        // ==========================================
        // BOTTOM SECTION: RESEARCH HISTORY & UPLOADS
        // ==========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Research History, Chats & Uploaded Docs",
              style: TextStyle(color: Color(0xFFF8AD5C), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _bg,
                foregroundColor: _accent,
                side: BorderSide(color: _accent, width: 1.5),
              ),
              onPressed: _uploadDocument,
              icon: const Icon(Icons.upload_file, size: 18),
              label: const Text("Upload Research Doc", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // History Table / List Container
        Container(
          decoration: BoxDecoration(
            color: _panelBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _bg,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                ),
                child: Row(
                  children: const [
                    Expanded(flex: 4, child: Text("TITLE / FILE NAME", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("PLATFORM USED", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("TYPE", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("DATE & TIME", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold))),
                    SizedBox(width: 50, child: Text("ACTION", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              // History Items
              _history.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text("No research history found.", style: TextStyle(color: Colors.white54)),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _history.length,
                      separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
                      itemBuilder: (context, index) {
                        final item = _history[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Icon(
                                      item.type == 'File' ? Icons.description : Icons.chat_bubble_outline,
                                      color: _accent,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  item.platformName,
                                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: _bg,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: item.type == 'File' ? Colors.blueAccent : Colors.greenAccent, width: 1),
                                  ),
                                  child: Text(
                                    item.type,
                                    style: TextStyle(
                                      color: item.type == 'File' ? Colors.blueAccent : Colors.greenAccent,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  item.dateTime,
                                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                  tooltip: "Remove History Item",
                                  onPressed: () => _removeHistoryItem(item.id),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}