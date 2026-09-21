import 'package:flutter/material.dart';
import 'dart:async';

// --- Data Models ---
enum FileCategory { frontend, backend }

class GitFile {
  final String fileName;
  final FileCategory category;
  String fetchTime;
  final String content;

  GitFile({
    required this.fileName,
    required this.category,
    required this.fetchTime,
    required this.content,
  });
}

// --- Main Widget ---
class OutlookWidget extends StatefulWidget {
  const OutlookWidget({super.key});

  @override
  State<OutlookWidget> createState() => _OutlookWidgetState();
}

class _OutlookWidgetState extends State<OutlookWidget> {
  // Theme colors
  final Color _panelBg = const Color(0xFF325453);
  final Color _accent = const Color(0xFFF8AD5C);
  final Color _bg = const Color(0xFF243B3A);
  final Color _codeBg = const Color(0xFF1B2D2C);

  // State Variables
  GitFile? _selectedFile;
  bool _isPulling = false;
  String _lastCommitHash = "a7f3b8c";

  // --- Mock Repository Data ---
  final String _repoName = "varun-ocean-monitoring";
  
  late List<GitFile> _files;

  @override
  void initState() {
    super.initState();
    _initializeFiles("2026-09-21 10:15 AM");
  }

  void _initializeFiles(String timestamp) {
    _files = [
      // Frontend (Vite + React)
      GitFile(
        fileName: "vite.config.js",
        category: FileCategory.frontend,
        fetchTime: timestamp,
        content: '''import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': 'http://127.0.0.1:8000', // Forward requests to FastAPI
    }
  }
})''',
      ),
      GitFile(
        fileName: "package.json",
        category: FileCategory.frontend,
        fetchTime: timestamp,
        content: '''{
  "name": "varun-ocean-frontend",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "lint": "eslint . --ext js,jsx",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.3.1",
    "vite": "^5.4.1"
  }
}''',
      ),
      GitFile(
        fileName: "src/App.jsx",
        category: FileCategory.frontend,
        fetchTime: timestamp,
        content: '''import { useState, useEffect } from 'react'
import './App.css'

function App() {
  const [systemStatus, setSystemStatus] = useState('Connecting...')

  useEffect(() => {
    fetch('/api/health')
      .then((res) => res.json())
      .then((data) => setSystemStatus(data.status))
      .catch((err) => setSystemStatus('Offline'));
  }, [])

  return (
    <div className="dashboard-container">
      <h1>Varun Ocean Monitoring UI</h1>
      <div className="status-badge">
        Backend Connection: {systemStatus}
      </div>
      <p>Awaiting live telemetry from deep-sea buoys...</p>
    </div>
  )
}

export default App''',
      ),

      // Backend (FastAPI)
      GitFile(
        fileName: "main.py",
        category: FileCategory.backend,
        fetchTime: timestamp,
        content: '''from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from models import TelemetryData

app = FastAPI(title="Varun Ocean Backend")

# Allow Vite frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/health")
async def health_check():
    return {"status": "Online", "version": "1.0.0"}

@app.post("/api/telemetry")
async def ingest_telemetry(data: TelemetryData):
    if data.salinity < 0:
        raise HTTPException(status_code=400, detail="Invalid salinity reading")
    
    # Process and save to buffer
    print(f"Received data from {data.buoy_id}")
    return {"status": "success", "recorded_at": data.timestamp}''',
      ),
      GitFile(
        fileName: "models.py",
        category: FileCategory.backend,
        fetchTime: timestamp,
        content: '''from pydantic import BaseModel
from datetime import datetime

class TelemetryData(BaseModel):
    buoy_id: str
    temperature: float
    salinity: float
    ph_level: float
    timestamp: datetime = datetime.now()
''',
      ),
      GitFile(
        fileName: "requirements.txt",
        category: FileCategory.backend,
        fetchTime: timestamp,
        content: '''fastapi==0.115.0
uvicorn==0.30.6
pydantic==2.9.2
''',
      ),
    ];
  }

  // Simulate pulling the latest commit
  Future<void> _pullLatestCommit() async {
    setState(() => _isPulling = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      // Generate a fake timestamp and commit hash
      final now = DateTime.now();
      String newTime = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
          "${now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour)}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
      
      _lastCommitHash = (now.millisecondsSinceEpoch % 10000000).toRadixString(16);
      
      // Update all files to new fetch time
      for (var file in _files) {
        file.fetchTime = newTime;
      }
      
      _isPulling = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully pulled latest commit: $_lastCommitHash', style: const TextStyle(color: Colors.black)),
          backgroundColor: _accent,
          duration: const Duration(seconds: 2),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Separate files by category
    final frontendFiles = _files.where((f) => f.category == FileCategory.frontend).toList();
    final backendFiles = _files.where((f) => f.category == FileCategory.backend).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ==========================================
        // HEADER: REPO INFO & PULL BUTTON
        // ==========================================
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _panelBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.source, color: Color(0xFFF8AD5C), size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_repoName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Git Repository • Commit: $_lastCommitHash", style: const TextStyle(color: Colors.white54, fontSize: 13)),
                    ],
                  ),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent, 
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                ),
                onPressed: _isPulling ? null : _pullLatestCommit,
                icon: _isPulling 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) 
                    : const Icon(Icons.cloud_sync, size: 18),
                label: Text(_isPulling ? "Pulling..." : "Pull Latest Commit", style: const TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ==========================================
        // BODY: FILE EXPLORER & CODE VIEWER
        // ==========================================
        SizedBox(
          height: 500, // Fixed height for the IDE-like viewer
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- LEFT PANEL: File Tree ---
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: _panelBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        color: _bg,
                        child: const Text("EXPLORER", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildFolderGroup("Frontend (Vite + React)", Icons.javascript, frontendFiles),
                            _buildFolderGroup("Backend (FastAPI)", Icons.data_object, backendFiles),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // --- RIGHT PANEL: Code Viewer ---
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: _panelBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Viewer Tab/Header
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: _bg,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _selectedFile == null ? Icons.code 
                              : _selectedFile!.fileName.endsWith('.py') ? Icons.data_object
                              : _selectedFile!.fileName.endsWith('.jsx') ? Icons.javascript
                              : Icons.description, 
                              color: _accent, 
                              size: 18
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedFile?.fileName ?? "Welcome", 
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                            ),
                            const Spacer(),
                            if (_selectedFile != null)
                              Text(
                                "Fetched: ${_selectedFile!.fetchTime}", 
                                style: const TextStyle(color: Colors.white30, fontSize: 12, fontStyle: FontStyle.italic)
                              ),
                          ],
                        ),
                      ),
                      // Code Editor Area
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _codeBg,
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                          ),
                          child: _selectedFile == null 
                            ? const Center(
                                child: Text("Select a file from the explorer to view its contents.", 
                                  style: TextStyle(color: Colors.white30, fontSize: 14)
                                )
                              )
                            : SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: SelectableText(
                                  _selectedFile!.content,
                                  style: const TextStyle(
                                    color: Color(0xFFE2E8F0), 
                                    fontFamily: 'monospace', 
                                    fontSize: 14, 
                                    height: 1.6
                                  ),
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

  // Helper widget to build folder headers and file lists
  Widget _buildFolderGroup(String folderName, IconData folderIcon, List<GitFile> files) {
    return ExpansionTile(
      initiallyExpanded: true,
      iconColor: _accent,
      collapsedIconColor: Colors.white54,
      title: Row(
        children: [
          Icon(folderIcon, color: _accent, size: 20),
          const SizedBox(width: 8),
          Text(folderName, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
      children: files.map((file) {
        bool isSelected = _selectedFile == file;
        return InkWell(
          onTap: () => setState(() => _selectedFile = file),
          child: Container(
            color: isSelected ? _bg.withOpacity(0.6) : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              children: [
                Icon(
                  file.fileName.endsWith('.py') ? Icons.data_object
                  : file.fileName.endsWith('.jsx') ? Icons.javascript
                  : Icons.description, 
                  color: isSelected ? _accent : Colors.white54, 
                  size: 16
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(file.fileName, style: TextStyle(color: isSelected ? _accent : Colors.white70, fontSize: 13)),
                      Text(file.fetchTime, style: const TextStyle(color: Colors.white30, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}