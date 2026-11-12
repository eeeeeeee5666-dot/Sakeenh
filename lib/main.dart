import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SakeenahApp());
}

class SakeenahApp extends StatelessWidget {
  const SakeenahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سكينة - Sakeenah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: const Color(0xFFF8FAF9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B4332),
          primary: const Color(0xFF1B4332),
          secondary: const Color(0xFF40916C),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DailyRoutineView(),
    const MoodDuaView(),
    const TasbihView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سَكِينَة',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), label: 'ورد اليوم'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), label: 'أدعية المشاعر'),
          NavigationDestination(icon: Icon(Icons.fingerprint), label: 'السبحة'),
        ],
      ),
    );
  }
}

// 1. شاشة ورد اليوم (Daily 3-min Routine)
class DailyRoutineView extends StatelessWidget {
  const DailyRoutineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'وردك المريح لليوم 🌿',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B4332)),
        ),
        const Text('3 دقائق تصنع فارقاً في يومك..', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),

        // بطاقة الآية
        _buildCard(
          title: 'آية وتدبر 📖',
          content: '«أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ»',
          subContent: 'التدبر: طمأنينة القلب ليست في غياب المشاكل، بل في استشعار معية الله وسطها.',
          color: const Color(0xFFD8F3DC),
        ),
        const SizedBox(height: 15),

        // بطاقة الذكر
        _buildCard(
          title: 'ذكر اليوم 📿',
          content: '«سُبْحَانَ اللهِ وَبِحَمْدِهِ» (10 مرات)',
          subContent: 'تغفر الذنوب وتبعث السكينة في الصدر قبل بدء مهامك.',
          color: const Color(0xFFB7E4C7),
        ),
        const SizedBox(height: 15),

        // بطاقة الأثر
        _buildCard(
          title: 'أثر اليوم (Micro-deed) 🤝',
          content: 'ابتسم في وجه أول شخص تصادفه أو ارسل دعاءً لصديق.',
          subContent: 'قليل دائم خير من كثير منقطع.',
          color: const Color(0xFFE9D8A6),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required String content, required String subContent, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(subContent, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ],
      ),
    );
  }
}

// 2. شاشة أدعية المشاعر (Mood-based Duas)
class MoodDuaView extends StatefulWidget {
  const MoodDuaView({super.key});

  @override
  State<MoodDuaView> createState() => _MoodDuaViewState();
}

class _MoodDuaViewState extends State<MoodDuaView> {
  String _selectedMood = 'قلق';

  final Map<String, Map<String, String>> _moodData = {
    'قلق': {
      'dua': '«اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ»',
      'meaning': 'الدعاء تفويض كامل لله ليحمل عنك أثقال الغد التي لا تملك السيطرة عليها.'
    },
    'شاكر': {
      'dua': '«الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ»',
      'meaning': 'الشكر قيد النعم القائمة، وجالب النعم القادمة.'
    },
    'تائه': {
      'dua': '«يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ»',
      'meaning': 'طلب التوجيه ممن بيده مقاليد السماوات والأرض حين تختلط عليك الدروب.'
    },
    'حزين': {
      'dua': '«إِنَّمَا أَشْكُو بَثِّي وَحُزْنِي إِلَى اللَّهِ»',
      'meaning': 'لست بحاجة لتبرير ضعفك لأحد، الله يعلم ما في صدرك قبل أن تنطق به.'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('بماذا يشعر قلبك الآن؟', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            children: _moodData.keys.map((mood) {
              final isSelected = _selectedMood == mood;
              return ChoiceChip(
                label: Text(mood, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                selected: isSelected,
                selectedColor: const Color(0xFF1B4332),
                onSelected: (val) {
                  if (val) setState(() => _selectedMood = mood);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.spa_outlined, size: 45, color: Color(0xFF2D6A4F)),
                  const SizedBox(height: 20),
                  Text(
                    _moodData[_selectedMood]!['dua']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.6),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _moodData[_selectedMood]!['meaning']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. شاشة السبحة الذكية مع Haptic Feedback
class TasbihView extends StatefulWidget {
  const TasbihView({super.key});

  @override
  State<TasbihView> createState() => _TasbihViewState();
}

class _TasbihViewState extends State<TasbihView> {
  int _counter = 0;

  void _increment() {
    HapticFeedback.lightImpact(); // اهتزاز ناعم عند التسبيح
    setState(() => _counter++);
  }

  void _reset() {
    HapticFeedback.mediumImpact();
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('سُبْحَانَ اللَّهِ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _increment,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Color(0xFF52B788), Color(0xFF1B4332)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2D6A4F).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '$_counter',
                style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('المس الدائرة للتسبيح', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 15),
          IconButton(
            onPressed: _reset,
            icon: const Icon(Icons.refresh, color: Colors.grey),
            tooltip: 'تصفير العداد',
          ),
        ],
      ),
    );
  }
}
