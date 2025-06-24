import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});

  final List<Nilai> nilaiList = const [
    Nilai(mataKuliah: 'Pemrograman Mobile', sks: 3, nilai: 'A', angka: 4.0),
    Nilai(mataKuliah: 'Basis Data', sks: 3, nilai: 'B+', angka: 3.5),
    Nilai(
      mataKuliah: 'Algoritma dan Struktur Data',
      sks: 4,
      nilai: 'A-',
      angka: 3.7,
    ),
    Nilai(mataKuliah: 'Jaringan Komputer', sks: 3, nilai: 'B', angka: 3.0),
    Nilai(
      mataKuliah: 'Rekayasa Perangkat Lunak',
      sks: 3,
      nilai: 'A',
      angka: 4.0,
    ),
  ];

  double get ipk {
    double totalBobot = 0;
    int totalSks = 0;

    for (var nilai in nilaiList) {
      totalBobot += nilai.angka * nilai.sks;
      totalSks += nilai.sks;
    }

    return totalBobot / totalSks;
  }

  int get totalSks {
    return nilaiList.fold(0, (sum, nilai) => sum + nilai.sks);
  }

  String get gradeDistribution {
    Map<String, int> distribution = {};
    for (var nilai in nilaiList) {
      distribution[nilai.nilai] = (distribution[nilai.nilai] ?? 0) + 1;
    }

    // Get the most common grade
    String mostCommon =
        distribution.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return mostCommon;
  }

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
                            Icons.school_outlined,
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
                                'Nilai Akademik',
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
                  ],
                ),
              ),
            ),

            // IPK Card
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
                child: Container(
                  padding: EdgeInsets.all(isTablet ? 24 : 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Index Prestasi Kumulatif',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ipk.toStringAsFixed(2),
                        style: textTheme.displayLarge?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 56 : 48,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getPredikat(ipk),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Statistics Cards
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(isTablet ? 24 : 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Total SKS',
                        totalSks.toString(),
                        Icons.library_books_outlined,
                        const Color(0xFF4CAF50),
                        isTablet,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Mata Kuliah',
                        nilaiList.length.toString(),
                        Icons.subject_outlined,
                        const Color(0xFF2196F3),
                        isTablet,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Grade Terbanyak',
                        gradeDistribution,
                        Icons.trending_up_outlined,
                        _getNilaiColor(gradeDistribution),
                        isTablet,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Grades List Header
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  isTablet ? 24 : 16,
                  0,
                  isTablet ? 24 : 16,
                  16,
                ),
                child: Text(
                  'Detail Nilai',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Grades List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ModernGradeCard(
                      nilai: nilaiList[index],
                      isTablet: isTablet,
                    ),
                  );
                }, childCount: nilaiList.length),
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
    bool isTablet,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(isTablet ? 16 : 14),
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
                  fontSize: isTablet ? 24 : 20,
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

  String _getPredikat(double ipk) {
    if (ipk >= 3.5) return 'Cum Laude';
    if (ipk >= 3.0) return 'Sangat Memuaskan';
    if (ipk >= 2.5) return 'Memuaskan';
    return 'Cukup';
  }

  Color _getNilaiColor(String nilai) {
    switch (nilai) {
      case 'A':
        return const Color(0xFF4CAF50);
      case 'A-':
        return const Color(0xFF66BB6A);
      case 'B+':
        return const Color(0xFF2196F3);
      case 'B':
        return const Color(0xFF42A5F5);
      case 'B-':
        return const Color(0xFFFF9800);
      case 'C+':
        return const Color(0xFFFFB74D);
      case 'C':
        return const Color(0xFFFF5722);
      case 'D':
        return const Color(0xFFF44336);
      case 'E':
        return const Color(0xFFD32F2F);
      default:
        return const Color(0xFF757575);
    }
  }
}

class Nilai {
  final String mataKuliah;
  final int sks;
  final String nilai;
  final double angka;

  const Nilai({
    required this.mataKuliah,
    required this.sks,
    required this.nilai,
    required this.angka,
  });
}

class ModernGradeCard extends StatelessWidget {
  final Nilai nilai;
  final bool isTablet;

  const ModernGradeCard({
    super.key,
    required this.nilai,
    required this.isTablet,
  });

  Color _getNilaiColor(String nilai) {
    switch (nilai) {
      case 'A':
        return const Color(0xFF4CAF50);
      case 'A-':
        return const Color(0xFF66BB6A);
      case 'B+':
        return const Color(0xFF2196F3);
      case 'B':
        return const Color(0xFF42A5F5);
      case 'B-':
        return const Color(0xFFFF9800);
      case 'C+':
        return const Color(0xFFFFB74D);
      case 'C':
        return const Color(0xFFFF5722);
      case 'D':
        return const Color(0xFFF44336);
      case 'E':
        return const Color(0xFFD32F2F);
      default:
        return const Color(0xFF757575);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final nilaiColor = _getNilaiColor(nilai.nilai);

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
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        child:
            isTablet
                ? _buildTabletLayout(
                  context,
                  textTheme,
                  colorScheme,
                  nilaiColor,
                )
                : _buildMobileLayout(
                  context,
                  textTheme,
                  colorScheme,
                  nilaiColor,
                ),
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    Color nilaiColor,
  ) {
    return Row(
      children: [
        // Left section - Subject
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nilai.mataKuliah,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.credit_card_outlined,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${nilai.sks} SKS',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.star_outline,
                    size: 16,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    nilai.angka.toStringAsFixed(1),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right section - Grade
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: nilaiColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: nilaiColor.withOpacity(0.3), width: 2),
          ),
          child: Center(
            child: Text(
              nilai.nilai,
              style: textTheme.titleLarge?.copyWith(
                color: nilaiColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    Color nilaiColor,
  ) {
    return Row(
      children: [
        // Left section - Subject name
        Expanded(
          flex: 4,
          child: Text(
            nilai.mataKuliah,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Middle section - SKS and Points
        SizedBox(
          width: 120,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.credit_card_outlined,
                      size: 20,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${nilai.sks}',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SKS',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 20,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nilai.angka.toStringAsFixed(1),
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Poin',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Right section - Grade
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: nilaiColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: nilaiColor.withOpacity(0.3), width: 3),
          ),
          child: Center(
            child: Text(
              nilai.nilai,
              style: textTheme.headlineMedium?.copyWith(
                color: nilaiColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
