import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  final List<JadwalKuliah> jadwalList = const [
    JadwalKuliah(
      mataKuliah: 'Pemrograman Mobile',
      dosen: 'Dr. Ahmad Wijaya',
      hari: 'Senin',
      waktu: '08:00 - 10:00',
      ruangan: 'Lab Komputer 1',
      kode: 'CS501',
    ),
    JadwalKuliah(
      mataKuliah: 'Basis Data',
      dosen: 'Ir. Siti Nurhaliza',
      hari: 'Selasa',
      waktu: '10:00 - 12:00',
      ruangan: 'Ruang 201',
      kode: 'CS502',
    ),
    JadwalKuliah(
      mataKuliah: 'Algoritma dan Struktur Data',
      dosen: 'Prof. Budi Santoso',
      hari: 'Rabu',
      waktu: '13:00 - 15:00',
      ruangan: 'Ruang 105',
      kode: 'CS503',
    ),
    JadwalKuliah(
      mataKuliah: 'Jaringan Komputer',
      dosen: 'Dr. Maya Sari',
      hari: 'Kamis',
      waktu: '08:00 - 10:00',
      ruangan: 'Lab Jaringan',
      kode: 'CS504',
    ),
    JadwalKuliah(
      mataKuliah: 'Rekayasa Perangkat Lunak',
      dosen: 'M.Kom. Andi Pratama',
      hari: 'Jumat',
      waktu: '10:00 - 12:00',
      ruangan: 'Ruang 301',
      kode: 'CS505',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              colorScheme.brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Modern Header
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(isTablet ? 24 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.schedule,
                            color: colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jadwal Kuliah',
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Semester Genap 2023/2024',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Total Mata Kuliah',
                            '${jadwalList.length}',
                            Icons.book_outlined,
                            colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            'Hari Aktif',
                            '5',
                            Icons.calendar_today_outlined,
                            colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Schedule List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ModernScheduleCard(
                      jadwal: jadwalList[index],
                      isTablet: isTablet,
                    ),
                  );
                }, childCount: jadwalList.length),
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const Spacer(),
              Text(
                value,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class JadwalKuliah {
  final String mataKuliah;
  final String dosen;
  final String hari;
  final String waktu;
  final String ruangan;
  final String kode;

  const JadwalKuliah({
    required this.mataKuliah,
    required this.dosen,
    required this.hari,
    required this.waktu,
    required this.ruangan,
    required this.kode,
  });
}

class ModernScheduleCard extends StatelessWidget {
  final JadwalKuliah jadwal;
  final bool isTablet;

  const ModernScheduleCard({
    super.key,
    required this.jadwal,
    required this.isTablet,
  });

  Color _getHariColor(String hari) {
    switch (hari.toLowerCase()) {
      case 'senin':
        return const Color(0xFF2196F3);
      case 'selasa':
        return const Color(0xFF4CAF50);
      case 'rabu':
        return const Color(0xFFFF9800);
      case 'kamis':
        return const Color(0xFF9C27B0);
      case 'jumat':
        return const Color(0xFFE91E63);
      case 'sabtu':
        return const Color(0xFF795548);
      case 'minggu':
        return const Color(0xFFEC407A);
      default:
        return const Color(0xFF757575);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hariColor = _getHariColor(jadwal.hari);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Color indicator
              Container(width: 4, color: hariColor),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 20 : 16),
                  child:
                      isTablet
                          ? _buildTabletLayout(
                            context,
                            textTheme,
                            colorScheme,
                            hariColor,
                          )
                          : _buildMobileLayout(
                            context,
                            textTheme,
                            colorScheme,
                            hariColor,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    Color hariColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with day and time
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: hariColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          jadwal.hari,
                          style: textTheme.bodySmall?.copyWith(
                            color: hariColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceVariant.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          jadwal.kode,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  jadwal.waktu,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Subject name
        Text(
          jadwal.mataKuliah,
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        // Lecturer and room
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      jadwal.dosen,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  jadwal.ruangan,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    Color hariColor,
  ) {
    return Row(
      children: [
        // Left section - Day and time
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: hariColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  jadwal.hari,
                  style: textTheme.bodyMedium?.copyWith(
                    color: hariColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                jadwal.waktu,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // Middle section - Subject and lecturer
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jadwal.mataKuliah,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                jadwal.dosen,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // Right section - Room and code
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    jadwal.ruangan,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  jadwal.kode,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
