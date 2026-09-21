import 'package:flutter/material.dart';

// --- Data Models ---
class DocFile {
  final String title;
  final String date;
  final String content;
  DocFile({required this.title, required this.date, required this.content});
}

class DiagramConnection {
  final String fromId;
  final String toId;
  DiagramConnection({required this.fromId, required this.toId});
}

class DiagramNode {
  String id;
  String label;
  double x;
  double y;
  // 0: Rect(Entity), 1: Circle(Process), 2: Diamond(Decision), 
  // 3: Ellipse(Attribute), 4: Data Store(DFD), 5: Database(Storage)
  int shapeType; 

  DiagramNode({
    required this.id,
    required this.label,
    required this.x,
    required this.y,
    this.shapeType = 0,
  });
}

class DiagramFile {
  final String title;
  final String date;
  final List<DiagramNode> nodes;
  final List<DiagramConnection> connections;
  DiagramFile({required this.title, required this.date, required this.nodes, required this.connections});
}


// --- Main Widget ---
class DocumentationWidget extends StatefulWidget {
  const DocumentationWidget({super.key});

  @override
  State<DocumentationWidget> createState() => _DocumentationWidgetState();
}

class _DocumentationWidgetState extends State<DocumentationWidget> {
  // --- Mock Data ---
  final List<DocFile> _docs = [
    DocFile(
      title: "System_Overview.txt",
      date: "2026-09-18",
      content: "PROJECT: Varun Ocean Monitoring System\n\n"
          "Overview: The Varun Ocean Monitoring System is designed to aggregate real-time telemetry from deep-sea buoys.\n\n"
          "Buffer Data Dump (Status: NORMAL):\n"
          "- Active Nodes: 42\n"
          "- Packet Loss: < 0.01%\n"
          "- Uplink Frequency: 1200 MHz",
    ),
    DocFile(
      title: "Sensor_Calibration.txt",
      date: "2026-09-20",
      content: "PROJECT: Varun Ocean Monitoring System\n\n"
          "Buffer Data - Sensor Readings array:\n"
          "[Node A1] pH: 8.1, Temp: 22.4°C, Salinity: 35.1 psu\n"
          "[Node A2] pH: 8.0, Temp: 21.9°C, Salinity: 35.0 psu\n"
          "[Node B1] pH: 7.9, Temp: 19.5°C, Salinity: 35.3 psu\n\n"
          "Notes: Node B1 requires recalibration next cycle.",
    ),
    DocFile(
      title: "Architecture_Draft.txt",
      date: "2026-09-21",
      content: "PROJECT: Varun Ocean Monitoring System\n\n"
          "Data Flow Requirements:\n"
          "1. Buoy array transmits UDP packets to Satellite relay.\n"
          "2. Ground station ingests buffer stream via AWS Kinesis.\n"
          "3. Processor validates timestamps and writes to PostgreSQL ER base.",
    ),
  ];

  final List<DiagramFile> _savedDiagrams = [
    DiagramFile(
      title: "Main DB Schema (ER)",
      date: "2026-09-15",
      nodes: [
        DiagramNode(id: "1", label: "Buoy_Node", x: 50, y: 50, shapeType: 0),
        DiagramNode(id: "2", label: "Coordinates", x: 250, y: 50, shapeType: 3), // Ellipse
      ],
      connections: [DiagramConnection(fromId: "1", toId: "2")],
    ),
    DiagramFile(
      title: "Telemetry Flow (DFD)",
      date: "2026-09-19",
      nodes: [
        DiagramNode(id: "1", label: "Ingest", x: 20, y: 100, shapeType: 1),
        DiagramNode(id: "2", label: "Validate?", x: 150, y: 80, shapeType: 2),
        DiagramNode(id: "3", label: "DB Storage", x: 300, y: 100, shapeType: 4), // Data store
      ],
      connections: [
        DiagramConnection(fromId: "1", toId: "2"),
        DiagramConnection(fromId: "2", toId: "3"),
      ],
    ),
  ];

  // State Variables
  int _selectedDocIndex = 0;
  int _selectedDiagramIndex = 0;
  
  List<DiagramNode> _activeNodes = [];
  List<DiagramConnection> _activeConnections = [];
  String? _selectedNodeId;
  
  // Line Drawing State
  bool _isLineMode = false;
  String? _connectingFromId;

  // Colors mapping your theme
  final Color _panelBg = const Color(0xFF325453);
  final Color _accent = const Color(0xFFF8AD5C);
  final Color _bg = const Color(0xFF243B3A);

  @override
  void initState() {
    super.initState();
    _loadDiagram(0);
  }

  void _loadDiagram(int index) {
    setState(() {
      _selectedDiagramIndex = index;
      _selectedNodeId = null;
      _isLineMode = false;
      _connectingFromId = null;
      
      _activeNodes = _savedDiagrams[index].nodes.map((n) => 
        DiagramNode(id: n.id, label: n.label, x: n.x, y: n.y, shapeType: n.shapeType)
      ).toList();
      _activeConnections = _savedDiagrams[index].connections.map((c) =>
        DiagramConnection(fromId: c.fromId, toId: c.toId)
      ).toList();
    });
  }

  // --- Downloads Mock ---
  void _mockDownload(String filename) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading $filename...', style: const TextStyle(color: Colors.black)),
        backgroundColor: _accent,
        duration: const Duration(seconds: 2),
      )
    );
  }

  // --- Diagram Tools ---
  void _addShape(int type) {
    setState(() {
      _activeNodes.add(DiagramNode(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        label: "New Node",
        x: 100,
        y: 100,
        shapeType: type,
      ));
    });
  }

  void _deleteSelectedNode() {
    if (_selectedNodeId != null) {
      setState(() {
        _activeNodes.removeWhere((n) => n.id == _selectedNodeId);
        _activeConnections.removeWhere((c) => c.fromId == _selectedNodeId || c.toId == _selectedNodeId);
        _selectedNodeId = null;
      });
    }
  }

  void _editNode(String nodeId) {
    final node = _activeNodes.firstWhere((n) => n.id == nodeId);
    TextEditingController ctrl = TextEditingController(text: node.label);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _panelBg,
        title: const Text("Edit Label", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFF8AD5C))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Cancel", style: TextStyle(color: Colors.white70))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _accent),
            onPressed: () {
              setState(() { node.label = ctrl.text; });
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }

  void _handleNodeTap(String nodeId) {
    setState(() {
      if (_isLineMode) {
        if (_connectingFromId == null) {
          _connectingFromId = nodeId; // Start line
        } else {
          // Finish line
          if (_connectingFromId != nodeId) {
            _activeConnections.add(DiagramConnection(fromId: _connectingFromId!, toId: nodeId));
          }
          _connectingFromId = null;
          _isLineMode = false; // Turn off line mode after connecting
        }
      } else {
        _selectedNodeId = nodeId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ==========================================
        // TOP SECTION: TEXT FILES 
        // ==========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Project Documentation", style: TextStyle(color: Color(0xFFF8AD5C), fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: () => _mockDownload("Varun_Docs_Archive.zip"),
              icon: const Icon(Icons.download, color: Color(0xFFF8AD5C), size: 18),
              label: const Text("Download All", style: TextStyle(color: Color(0xFFF8AD5C))),
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: Row(
            children: [
              // File List Sidebar
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: _panelBg, borderRadius: BorderRadius.circular(8)),
                  child: ListView.builder(
                    itemCount: _docs.length,
                    itemBuilder: (context, index) {
                      bool isSel = index == _selectedDocIndex;
                      return ListTile(
                        title: Text(_docs[index].title, style: TextStyle(color: isSel ? _accent : Colors.white, fontSize: 13)),
                        subtitle: Text(_docs[index].date, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                        leading: Icon(Icons.description, color: isSel ? _accent : Colors.white70),
                        selected: isSel,
                        selectedTileColor: _bg.withOpacity(0.5),
                        onTap: () => setState(() => _selectedDocIndex = index),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Document Viewer
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(color: _panelBg, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: _bg, borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_docs[_selectedDocIndex].title, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.download_outlined, color: Colors.white70, size: 20),
                              tooltip: "Download Current File",
                              onPressed: () => _mockDownload(_docs[_selectedDocIndex].title),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _docs[_selectedDocIndex].content,
                            style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5, fontFamily: 'monospace'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // ==========================================
        // BOTTOM SECTION: DIAGRAM EDITOR
        // ==========================================
        const Text("Site ER / Data Flow Diagrams", style: TextStyle(color: Color(0xFFF8AD5C), fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 400,
          child: Row(
            children: [
              // Diagram Sidebar
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: _panelBg, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        color: _bg,
                        child: const Text("Saved Diagrams", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _savedDiagrams.length,
                          itemBuilder: (context, index) {
                            bool isSel = index == _selectedDiagramIndex;
                            return ListTile(
                              title: Text(_savedDiagrams[index].title, style: TextStyle(color: isSel ? _accent : Colors.white, fontSize: 13)),
                              subtitle: Text(_savedDiagrams[index].date, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                              leading: Icon(Icons.account_tree, color: isSel ? _accent : Colors.white70),
                              selected: isSel,
                              selectedTileColor: _bg.withOpacity(0.5),
                              onTap: () => _loadDiagram(index),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: _accent, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 40)),
                          onPressed: () {
                            setState(() {
                              _savedDiagrams.add(DiagramFile(title: "New Diagram", date: "Today", nodes: [], connections: []));
                              _loadDiagram(_savedDiagrams.length - 1);
                            });
                          },
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text("New"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Diagram Canvas
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2D2C), 
                    border: Border.all(color: _panelBg, width: 2),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      // Toolbar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        color: _panelBg,
                        child: Row(
                          children: [
                            Tooltip(message: "Rectangle (Entity)", child: IconButton(icon: const Icon(Icons.check_box_outline_blank, color: Colors.white), onPressed: () => _addShape(0))),
                            Tooltip(message: "Ellipse (Attribute)", child: IconButton(icon: const Icon(Icons.panorama_fish_eye, color: Colors.white), onPressed: () => _addShape(3))),
                            Tooltip(message: "Diamond (Decision)", child: IconButton(icon: const Icon(Icons.change_history, color: Colors.white), onPressed: () => _addShape(2))),
                            Tooltip(message: "Data Store (DFD)", child: IconButton(icon: const Icon(Icons.view_stream, color: Colors.white), onPressed: () => _addShape(4))),
                            Tooltip(message: "Database", child: IconButton(icon: const Icon(Icons.storage, color: Colors.white), onPressed: () => _addShape(5))),
                            
                            const SizedBox(width: 10),
                            Container(width: 1, height: 24, color: Colors.white30),
                            const SizedBox(width: 10),
                            
                            Tooltip(
                              message: "Draw Line Tool", 
                              child: IconButton(
                                icon: Icon(Icons.linear_scale, color: _isLineMode ? _accent : Colors.white), 
                                onPressed: () => setState(() => _isLineMode = !_isLineMode),
                              )
                            ),
                            
                            const Spacer(),
                            const Text("Double-tap shape to edit", style: TextStyle(color: Colors.white30, fontSize: 12, fontStyle: FontStyle.italic)),
                            const SizedBox(width: 10),
                            if (_selectedNodeId != null) ...[
                              TextButton.icon(
                                style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                                icon: const Icon(Icons.delete, size: 16),
                                label: const Text("Remove"),
                                onPressed: _deleteSelectedNode,
                              ),
                            ]
                          ],
                        ),
                      ),
                      // Interactive Canvas
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                          child: GestureDetector(
                            onTap: () => setState(() {
                              _selectedNodeId = null;
                              if(_isLineMode) _connectingFromId = null; // reset line if background clicked
                            }),
                            child: Stack(
                              children: [
                                // Paint Lines Behind Shapes
                                CustomPaint(
                                  size: const Size(double.infinity, double.infinity),
                                  painter: ConnectionPainter(nodes: _activeNodes, connections: _activeConnections),
                                ),
                                
                                // Draw Shapes
                                ..._activeNodes.map((node) {
                                  bool isNodeSel = node.id == _selectedNodeId;
                                  bool isLineSource = node.id == _connectingFromId;
                                  return Positioned(
                                    left: node.x,
                                    top: node.y,
                                    child: GestureDetector(
                                      onTap: () => _handleNodeTap(node.id),
                                      onDoubleTap: () {
                                        _selectedNodeId = node.id;
                                        _editNode(node.id);
                                      },
                                      onPanUpdate: (details) {
                                        if (!_isLineMode) {
                                          setState(() {
                                            _selectedNodeId = node.id;
                                            node.x += details.delta.dx;
                                            node.y += details.delta.dy;
                                          });
                                        }
                                      },
                                      child: _buildShape(node, isNodeSel, isLineSource),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Shape Builder ---
  Widget _buildShape(DiagramNode node, bool isSelected, bool isLineSource) {
    Widget shapeWidget;
    Color borderColor = isSelected ? _accent : (isLineSource ? Colors.greenAccent : Colors.white54);
    double borderWidth = isSelected || isLineSource ? 3.0 : 1.5;

    switch(node.shapeType) {
      case 0: // Rectangle
        shapeWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _bg,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(node.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      case 1: // Circle (Process)
        shapeWidget = Container(
          alignment: Alignment.center,
          width: 90, height: 90,
          decoration: BoxDecoration(color: _bg, shape: BoxShape.circle, border: Border.all(color: borderColor, width: borderWidth)),
          child: Text(node.label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      case 2: // Diamond (Decision)
        shapeWidget = Transform.rotate(
          angle: 0.785398, // 45 deg
          child: Container(
            width: 80, height: 80,
            decoration: BoxDecoration(color: _bg, border: Border.all(color: borderColor, width: borderWidth)),
            child: Transform.rotate(
              angle: -0.785398, // rotate text back
              child: Center(child: Text(node.label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
            ),
          ),
        );
        break;
      case 3: // Ellipse (Attribute)
        shapeWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _bg,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(50), // Creates ellipse shape
          ),
          child: Text(node.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      case 4: // Data Store (DFD - Open Rect)
        shapeWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _bg,
            border: Border(
              top: BorderSide(color: borderColor, width: borderWidth),
              bottom: BorderSide(color: borderColor, width: borderWidth),
            ),
          ),
          child: Text(node.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
        break;
      case 5: // Database (Cylinder/Storage)
        shapeWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _bg,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.storage, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(node.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        );
        break;
      default:
        shapeWidget = const SizedBox();
    }
    return shapeWidget;
  }
}

// --- Custom Painter for Connection Lines ---
class ConnectionPainter extends CustomPainter {
  final List<DiagramNode> nodes;
  final List<DiagramConnection> connections;

  ConnectionPainter({required this.nodes, required this.connections});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF8AD5C)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var conn in connections) {
      try {
        final node1 = nodes.firstWhere((n) => n.id == conn.fromId);
        final node2 = nodes.firstWhere((n) => n.id == conn.toId);

        // Approximate centers (adding 40 to X and Y is a safe rough center for most shapes)
        final p1 = Offset(node1.x + 40, node1.y + 40);
        final p2 = Offset(node2.x + 40, node2.y + 40);

        canvas.drawLine(p1, p2, paint);
        
        // Draw an arrowhead roughly in the middle
        final midP = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
        canvas.drawCircle(midP, 4, Paint()..color = const Color(0xFFF8AD5C));
        
      } catch (e) {
        // Node was deleted but connection remained, skip drawing
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}