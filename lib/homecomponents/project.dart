import 'package:catalyst/homecomponents/components/projectdashboard.dart';
import 'package:catalyst/homecomponents/documentation.dart';
import 'package:catalyst/homecomponents/githubrepo.dart';
import 'package:catalyst/homecomponents/outlook.dart';
import 'package:catalyst/homecomponents/research.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// IMPORTANT: Uncomment your actual component imports below
// import 'package:catalyst/homecomponents/githubrepo.dart';
// import 'package:catalyst/homecomponents/components/projectdashboard.dart';
// import 'package:catalyst/homecomponents/smaller component/navbarbutton.dart'; // You may no longer need this one!

class Projectpage extends StatefulWidget {
  const Projectpage({super.key});

  @override
  State<Projectpage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<Projectpage> {
  // 1. State variable to keep track of the currently selected tab
  String _activeTab = 'Progress';

  // 2. Helper method to return the correct widget based on the active tab
  Widget _buildMainContent() {
    switch (_activeTab) {
      case 'Progress':
        return const ProjectDashboardCard(); 
      case 'GitHub':
        return const GithubWidget(); 
      case 'Documentation':
        return const DocumentationWidget(); 
      case 'Outlook':
        return const OutlookWidget(); 
      case 'Research':
        return const ResearchWidget(); 
      case 'About':
        return const AboutWidget(); 
      case 'Terms & Conditions':
        return const TermsWidget(); 
      default:
        return const ProjectDashboardCard();
    }
  }

  // 3. REWRITTEN NAV ITEM: Guaranteed to catch taps and highlights the active tab
  Widget _buildNavItem(String title) {
    bool isSelected = _activeTab == title;

    return InkWell(
      onTap: () {
        setState(() {
          _activeTab = title; // This now safely updates the state
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          // Highlight background if selected
          color: isSelected ? const Color(0xFF243B3A) : Colors.transparent,
          border: Border(
            left: BorderSide(
              // Orange indicator line on the left if selected
              color: isSelected ? const Color(0xFFF8AD5C) : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            // Highlight text color if selected
            color: isSelected ? const Color(0xFFF8AD5C) : Colors.white70,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF325453),
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(2),
                  minimumSize: const Size(1, 1),
                  maximumSize: const Size(32, 32),
                ),
                child: const Icon(
                  Icons.menu,
                  size: 30,
                  color: Color(0xFFF8AD5C),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "Catalyst",
                style: GoogleFonts.anta(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF8AD5C),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Text(
                'Projects',
                style: TextStyle(
                  color: Color(0xFFF8AD5C),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 30),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF325453),
                  foregroundColor: const Color(0xFFF8AD5C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                      color: Color(0xFFF8AD5C),
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text("SIGNIN/UP"),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // -------------------------------------------------------------
          // LEFT SIDEBAR
          // -------------------------------------------------------------
          Container(
            width: 280,
            color: const Color(0xFF325453),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profilepage');
                  },
                  child: Container(
                    color: const Color(0xFFB92A0F),
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28.0,
                          backgroundColor: Color(0xFFF8AD5C),
                          child: Icon(Icons.person, color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "User Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Developer",
                                style: TextStyle(
                                  color: Color(0xFFF7E4CC),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Navigation Link Items
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNavItem("Progress"),
                        _buildNavItem("GitHub"),
                        _buildNavItem("Documentation"),
                        _buildNavItem("Outlook"),
                        _buildNavItem("Research"),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: Color(0xFFF8AD5C), thickness: 0.5),
                        ),
                        _buildNavItem("About"),
                        _buildNavItem("Terms & Conditions"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------------------------------------------
          // RIGHT MAIN CONTENT
          // -------------------------------------------------------------
          Expanded(
            child: Container(
              color: const Color(0xFF243B3A),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildMainContent(), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PLACEHOLDER WIDGETS
// =====================================================================




class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("About the Project", style: TextStyle(color: Colors.white, fontSize: 24)));
}

class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Terms & Conditions", style: TextStyle(color: Colors.white, fontSize: 24)));
}