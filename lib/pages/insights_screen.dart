part of '../main.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  static const _trends = <CareerTrend>[
    CareerTrend(
      name: 'AI & Machine Learning',
      growth: '+24%',
      colorValue: 0xFF24D8FF,
      progress: .87,
      category: 'Technology',
      icon: CareerGlyph.intelligence,
    ),
    CareerTrend(
      name: 'Data Science',
      growth: '+20%',
      colorValue: 0xFF9C83FF,
      progress: .75,
      category: 'Data',
      icon: CareerGlyph.data,
    ),
    CareerTrend(
      name: 'Cybersecurity',
      growth: '+18%',
      colorValue: 0xFFFFC857,
      progress: .67,
      category: 'Technology',
      icon: CareerGlyph.code,
    ),
    CareerTrend(
      name: 'Cloud Development',
      growth: '+16%',
      colorValue: 0xFF72D8A4,
      progress: .59,
      category: 'Technology',
      icon: CareerGlyph.code,
    ),
    CareerTrend(
      name: 'Product Design',
      growth: '+12%',
      colorValue: 0xFFFFA76B,
      progress: .46,
      category: 'Design',
      icon: CareerGlyph.design,
    ),
    CareerTrend(
      name: 'Product Management',
      growth: '+10%',
      colorValue: 0xFFFFC857,
      progress: .39,
      category: 'Business',
      icon: CareerGlyph.product,
    ),
  ];

  final _location = TextEditingController(text: 'Pakistan');
  bool _industryMode = false;
  String _industry = 'All';

  List<CareerTrend> get _visibleTrends => !_industryMode || _industry == 'All'
      ? _trends
      : _trends.where((trend) => trend.category == _industry).toList();

  @override
  void dispose() {
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
    children: [
      const Text(
        'Job market insights',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 5),
      const Text(
        'Signals shaping the careers of tomorrow',
        style: TextStyle(color: _muted, fontSize: 12),
      ),
      const SizedBox(height: 4),
      const Text(
        'Illustrative market snapshot',
        style: TextStyle(color: _muted, fontSize: 10),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _location,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _searchMarket(),
              decoration: const InputDecoration(
                labelText: 'Search live market information',
                prefixIcon: Icon(Icons.public),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            tooltip: 'Search Google',
            onPressed: _searchMarket,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      const SizedBox(height: 18),
      SegmentedButton<bool>(
        segments: const [
          ButtonSegment(value: false, label: Text('Trending')),
          ButtonSegment(value: true, label: Text('By industry')),
        ],
        selected: {_industryMode},
        onSelectionChanged: (selection) =>
            setState(() => _industryMode = selection.first),
      ),
      if (_industryMode) ...[
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _industry,
          decoration: const InputDecoration(
            labelText: 'Industry',
            isDense: true,
          ),
          items: const ['All', 'Technology', 'Data', 'Design', 'Business']
              .map(
                (industry) =>
                    DropdownMenuItem(value: industry, child: Text(industry)),
              )
              .toList(),
          onChanged: (value) => setState(() => _industry = value ?? 'All'),
        ),
      ],
      const SizedBox(height: 18),
      const SectionTitle('Fast-growing career fields'),
      const SizedBox(height: 10),
      if (_visibleTrends.isEmpty)
        const AppPanel(
          child: Text(
            'No market data for this industry.',
            style: TextStyle(color: _muted),
          ),
        ),
      for (final trend in _visibleTrends)
        _GrowthRow(
          icon: _careerIcon(trend.icon),
          name: trend.name,
          change: trend.growth,
          color: Color(trend.colorValue),
          value: trend.progress,
        ),
      const SizedBox(height: 24),
      const SectionTitle('Market overview'),
      const SizedBox(height: 10),
      Row(
        children: const [
          Expanded(
            child: MetricTile(
              label: 'Open roles',
              value: '2.5M',
              icon: Icons.work_outline,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: MetricTile(
              label: 'Avg. salary',
              value: '\$78k',
              icon: Icons.payments_outlined,
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      const AppPanel(
        child: Text(
          'Skills in demand: critical thinking, AI literacy, collaboration, and adaptability.',
          style: TextStyle(color: _muted, height: 1.5, fontSize: 12),
        ),
      ),
    ],
  );

  Future<void> _searchMarket() => _openGoogleSearch(
    context,
    'job market hiring trends career opportunities ${_location.text.trim()}',
  );
}

class _GrowthRow extends StatelessWidget {
  const _GrowthRow({
    required this.icon,
    required this.name,
    required this.change,
    required this.color,
    required this.value,
  });

  final IconData icon;
  final String name;
  final String change;
  final Color color;
  final double value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: AppPanel(
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: color.withValues(alpha: .13),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      change,
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 4,
                    color: color,
                    backgroundColor: _line,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
