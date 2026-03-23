import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//================= APP ROOT =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Banking',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

//================= MAIN PAGE =================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    MutasiPage(),
    AktivitasPage(),
    AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Mutasi"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Aktivitas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }
}

//================= HOME PAGE =================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hideSaldo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      //===== HEADER =====
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selamat Malam", style: TextStyle(fontSize: 14)),
            Text(
              "User Mobile Banking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 12),
          Icon(Icons.help_outline),
          SizedBox(width: 12),
        ],
      ),

      // =====BODY =====
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== SALDO CARD =====
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Saldo Rekening Utama",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hideSaldo ? "........" : "Rp 10.000.000",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          hideSaldo ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            hideSaldo = !hideSaldo;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // =====MENU CEPAT =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MenuIcon(
                  icon: Icons.send,
                  title: "Transfer",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransferPage(),
                      ),
                    );
                  },
                ),
                const MenuIcon(icon: Icons.payment, title: "BRIVA"),
                const MenuIcon(icon: Icons.water_drop, title: "PDAM"),
                const MenuIcon(icon: Icons.phone_android, title: "Pulsa"),
              ],
            ),

            const SizedBox(height: 20),

            // ===== BANNER =====
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/200"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== SEARCH =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari fitur...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== GRID MENU =====
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  MenuIcon(icon: Icons.add, title: "Top Up"),
                  MenuIcon(icon: Icons.credit_card, title: "BRIZZI"),
                  MenuIcon(icon: Icons.receipt, title: "Tagihan"),
                  MenuIcon(icon: Icons.send, title: "Transfer"),
                  MenuIcon(icon: Icons.shopping_bag, title: "Lifestyle"),
                  MenuIcon(icon: Icons.atm, title: "ATM"),
                  MenuIcon(icon: Icons.note, title: "Catatan"),
                  MenuIcon(icon: Icons.trending_up, title: "Investasi"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= MENU AICON =================
class MenuIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const MenuIcon({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// ================= TRANSFER PAGE =================
class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController rekeningController = TextEditingController();
    final TextEditingController nominalController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Transfer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: rekeningController,
              decoration: const InputDecoration(labelText: "No Rekening"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Nominal"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Berhasil"),
                    content: const Text("Transfer berhasil dilakukan"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Kirim"),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HALAMAN LAIN =================
class MutasiPage extends StatelessWidget {
  const MutasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Halaman Mutasi")));
  }
}

class AktivitasPage extends StatelessWidget {
  const AktivitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Halaman Aktivitas")));
  }
}

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Halaman Akun")));
  }
}
