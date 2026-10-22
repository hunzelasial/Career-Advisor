part of '../main.dart';

class CareerPhoto extends StatelessWidget {
  const CareerPhoto({
    super.key,
    required this.imageUrl,
    required this.icon,
    required this.color,
    this.height = 120,
  });

  final String imageUrl;
  final IconData icon;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(9),
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => ColoredBox(
          color: color.withValues(alpha: .12),
          child: Center(child: Icon(icon, size: 38, color: color)),
        ),
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : ColoredBox(
                color: color.withValues(alpha: .08),
                child: Center(
                  child: CircularProgressIndicator(
                    value: progress.expectedTotalBytes == null
                        ? null
                        : progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!,
                    strokeWidth: 2,
                    color: color,
                  ),
                ),
              ),
      ),
    ),
  );
}

class CareerHero extends StatelessWidget {
  const CareerHero({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: SizedBox(
      height: 184,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1556761175-b413da4baf72?auto=format&fit=crop&w=1400&q=85',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const ColoredBox(
              color: Color(0xFF123356),
              child: Icon(Icons.explore_outlined, color: _cyan, size: 46),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.transparent, Color(0xEA06101F)],
                stops: [0, .78],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your next chapter starts here',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Find a path that fits the way you think.',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 34,
                    child: FilledButton.icon(
                      onPressed: onTap,
                      icon: const Icon(Icons.arrow_forward, size: 15),
                      label: const Text('Explore careers'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _blue,
                        padding: const EdgeInsets.symmetric(horizontal: 13),
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
  );
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.onTap,
    required this.completion,
  });

  final VoidCallback onTap;
  final int completion;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
        gradient: const LinearGradient(
          colors: [Color(0xFF10274A), Color(0xFF0B1730)],
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF1A4775),
            child: Icon(Icons.person_outline, color: _cyan),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your career profile',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  'Explore roles that fit your strengths',
                  style: TextStyle(color: _muted, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '$completion%',
            style: const TextStyle(color: _cyan, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}

class ToolTile extends StatelessWidget {
  const ToolTile({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.imageUrl,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: _panel,
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => ColoredBox(
                color: color.withValues(alpha: .14),
                child: Center(child: Icon(icon, color: color, size: 36)),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x33030A16), Color(0xE8030A16)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xB8081730),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Icon(icon, color: color, size: 20),
                    ),
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _line),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class InsightHighlight extends StatelessWidget {
  const InsightHighlight({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: _panel,
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _line),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF153A63),
              child: Icon(Icons.auto_graph, color: _cyan, size: 20),
            ),
            SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Technology careers in 2026',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'AI & machine learning roles are growing',
                    style: TextStyle(fontSize: 10, color: _muted),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: _muted),
          ],
        ),
      ),
    ),
  );
}

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => AppPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _cyan, size: 19),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
        ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(color: _muted, fontSize: 10)),
      ],
    ),
  );
}

class CareerRow extends StatelessWidget {
  const CareerRow({
    super.key,
    required this.name,
    required this.detail,
    required this.icon,
    required this.color,
  });

  final String name;
  final String detail;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: _line),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: color.withValues(alpha: .13),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(detail, style: const TextStyle(color: _cyan, fontSize: 10)),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: _muted, size: 18),
      ],
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  );
}

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}

class SkillPill extends StatelessWidget {
  const SkillPill(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Chip(
    label: Text(label, style: const TextStyle(fontSize: 10)),
    backgroundColor: const Color(0xFF102B48),
    side: BorderSide(color: _cyan.withValues(alpha: .18)),
    padding: const EdgeInsets.symmetric(horizontal: 2),
    visualDensity: VisualDensity.compact,
  );
}

class ChoiceChips extends StatefulWidget {
  const ChoiceChips({super.key, required this.values});

  final List<String> values;

  @override
  State<ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  int selected = 0;

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(widget.values.length, (index) {
      final active = selected == index;
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(widget.values[index]),
          selected: active,
          onSelected: (_) => setState(() => selected = index),
          showCheckmark: false,
          labelStyle: TextStyle(
            color: active ? Colors.white : _muted,
            fontSize: 11,
          ),
          backgroundColor: _panel,
          selectedColor: _blue,
          side: BorderSide(color: active ? _blue : _line),
          visualDensity: VisualDensity.compact,
        ),
      );
    }),
  );
}

class AppPanel extends StatelessWidget {
  const AppPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _line),
    ),
    child: child,
  );
}

class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.current});

  final int current;

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(
      4,
      (index) => Expanded(
        child: Container(
          height: 4,
          margin: EdgeInsets.only(right: index == 3 ? 0 : 7),
          decoration: BoxDecoration(
            color: index < current ? _blue : _line,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    ),
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 48,
    child: FilledButton(
      onPressed: busy ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _blue,
        disabledBackgroundColor: _blue.withValues(alpha: .5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
      child: busy
          ? const SizedBox(
              width: 19,
              height: 19,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    ),
  );
}

class ProfileAction extends StatelessWidget {
  const ProfileAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    leading: Icon(icon, color: _cyan, size: 20),
    title: Text(label, style: const TextStyle(fontSize: 13)),
    trailing: const Icon(Icons.chevron_right, color: _muted, size: 19),
    onTap: onTap,
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
