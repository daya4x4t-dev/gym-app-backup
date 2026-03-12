import re

file_path = r"c:\Users\Dell\AndroidStudioProjects\gym\lib\screens\home_dashboard.dart"

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace _buildGreeting carefully
start_marker = "  Widget _buildGreeting() {"
end_marker = "  }\n\n  Widget _buildSearchBar() {"

start_idx = content.find(start_marker)
end_idx = content.find(end_marker)

if start_idx != -1 and end_idx != -1:
    old_greeting = content[start_idx:end_idx]
    
    new_greeting = """  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF5F5), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.red.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: _accentRed.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Good Morning, Hinata',
                        style: TextStyle(
                          color: _textDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('👋', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ready for today\\'s workout?',
                    style: TextStyle(
                      color: _textGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _accentRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flash_on, color: _accentRed, size: 28),
            ),
          ],
        ),
      ),
    );
"""
    content = content[:start_idx] + new_greeting + content[end_idx:]

content = content.replace("'Search workouts, gyms or equipmen',", "'Search workouts, gyms or equipment',")

with open(file_path, 'w', encoding='utf-8', newline='') as f:
    f.write(content)

print("Updated successfully")
