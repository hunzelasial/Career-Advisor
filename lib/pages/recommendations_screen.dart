part of '../main.dart';

CareerRoadmapStep _step(String title, String description, String duration) =>
    CareerRoadmapStep(
      title: title,
      description: description,
      duration: duration,
    );

String _careerImageUrl(String title, CareerGlyph glyph) {
  final imageId = switch (title) {
    'Software Engineer' => '1519389950473-47ba0277781c',
    'Data Analyst' => '1551288049-bebda4e38f71',
    'Data Scientist' => '1460925895917-afdab827c52f',
    'Cybersecurity Analyst' => '1550751827-4bd374c3f58b',
    'AI / ML Engineer' => '1677442136019-21780ecad995',
    'UX / Product Designer' => '1586717791821-3f44a563fa4c',
    'UX Designer' => '1581291518857-4e27b48ff24e',
    'Teacher / Educator' => '1503676260728-1c00da094a0b',
    'Nurse' => '1576091160399-112ba8d25d1d',
    'Accountant' => '1554224155-6726b3ff858f',
    'Marketing Specialist' => '1533750349088-cd871a92f312',
    'Human Resources Coordinator' => '1521737711867-e3b97375f902',
    'Product Manager' => '1556761175-b413da4baf72',
    'Civil Engineer' => '1504307651254-35680f356dfd',
    'Electrician' => '1621905251189-1d5c1cf1a7f1',
    'Graphic Designer' => '1497366216548-37526070297c',
    'Journalist / Reporter' => '1504711434969-e33886168f5c',
    'Environmental Scientist' => '1470071459604-3b5ec3a7fe05',
    'Social Worker' => '1529156069898-49953e39b3ac',
    'Chef / Culinary Professional' => '1556911220-bff31c812dba',
    'Project Coordinator' => '1522071820081-009f0129c71c',
    'Agriculture & Food Systems Specialist' => '1500382017468-9049fed747ef',
    'Financial Planner' => '1579621970563-ebec7560ff3e',
    'Lawyer / Legal Professional' => '1589829545856-d10d557cf95f',
    'Operations & Supply Chain Analyst' => '1586528116311-ad8dd3c8310d',
    _ => switch (glyph) {
      CareerGlyph.code => '1519389950473-47ba0277781c',
      CareerGlyph.data => '1551288049-bebda4e38f71',
      CareerGlyph.design => '1586717791821-3f44a563fa4c',
      CareerGlyph.intelligence => '1677442136019-21780ecad995',
      CareerGlyph.product => '1556761175-b413da4baf72',
    },
  };
  return 'https://images.unsplash.com/photo-$imageId?auto=format&fit=crop&w=1200&q=80';
}

CareerRole _career({
  required String title,
  required String summary,
  required String category,
  required CareerGlyph glyph,
  required int color,
  required List<String> skills,
  required String education,
  required List<CareerRoadmapStep> steps,
  required List<String> tryIt,
}) => CareerRole(
  title: title,
  summary: summary,
  matchScore: 0,
  glyph: glyph,
  colorValue: color,
  skills: skills,
  imageUrl: _careerImageUrl(title, glyph),
  salaryRange: 'Varies by location and experience',
  growth: 'Check local demand',
  category: category,
  learningPath: steps.map((step) => step.title).toList(),
  roadmap: steps,
  education: education,
  tryIt: tryIt,
);

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key, this.savedOnly = false});

  final bool savedOnly;

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  static final roles = <CareerRole>[
    _career(
      title: 'Software Engineer',
      summary: 'Build and maintain apps, websites, and services.',
      category: 'Technology',
      glyph: CareerGlyph.code,
      color: 0xFF24D8FF,
      skills: ['Programming', 'Problem solving', 'Teamwork'],
      education:
          'A degree or vocational route can help; many employers also accept strong projects and demonstrated skills.',
      steps: [
        _step(
          'Learn the foundations',
          'Choose one language, practice logic, Git, and basic command-line skills.',
          '1-3 months',
        ),
        _step(
          'Build useful projects',
          'Create and publish two small apps; write tests and explain your design decisions.',
          '3-8 months',
        ),
        _step(
          'Work with others',
          'Contribute to a team project, internship, open-source project, or student club.',
          '6-12 months',
        ),
        _step(
          'Prepare and apply',
          'Practice coding exercises, review fundamentals, tailor your CV, and apply for junior roles.',
          'Ongoing',
        ),
      ],
      tryIt: [
        'Build a simple app that solves a real student problem.',
        'Ask a developer to review your code.',
      ],
    ),
    _career(
      title: 'Data Analyst',
      summary: 'Turn data into clear findings that support decisions.',
      category: 'Technology & Data',
      glyph: CareerGlyph.data,
      color: 0xFF9C83FF,
      skills: ['Spreadsheets', 'SQL', 'Statistics', 'Communication'],
      education:
          'Study in analytics, business, science, or another quantitative subject is useful; practical work samples matter.',
      steps: [
        _step(
          'Learn data basics',
          'Practice spreadsheets, descriptive statistics, data quality, and clear chart design.',
          '1-3 months',
        ),
        _step(
          'Add analysis tools',
          'Learn SQL and one visualization tool; document how you clean and check data.',
          '2-5 months',
        ),
        _step(
          'Publish case studies',
          'Analyze public data, explain a question and method, then share a dashboard and concise findings.',
          '3-8 months',
        ),
        _step(
          'Get experience and apply',
          'Volunteer for a student group or nonprofit and apply for analyst internships and junior roles.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Analyze an open dataset about a topic you care about.',
        'Present three evidence-backed findings in one page.',
      ],
    ),
    _career(
      title: 'Data Scientist',
      summary: 'Use statistics and programming to answer complex questions.',
      category: 'Technology & Data',
      glyph: CareerGlyph.data,
      color: 0xFF9C83FF,
      skills: ['Statistics', 'Python', 'SQL', 'Critical thinking'],
      education:
          'A quantitative degree is common; demonstrate sound statistical reasoning and reproducible projects.',
      steps: [
        _step(
          'Build quantitative foundations',
          'Study statistics, probability, algebra, and data ethics.',
          '2-6 months',
        ),
        _step(
          'Learn analysis tools',
          'Practice Python, SQL, data cleaning, visualization, and reproducible notebooks.',
          '3-8 months',
        ),
        _step(
          'Complete end-to-end projects',
          'Use public datasets to frame a question, compare methods, explain uncertainty, and share results.',
          '4-10 months',
        ),
        _step(
          'Gain experience and apply',
          'Seek research or analytics internships and prepare to explain your assumptions and model limits.',
          '6-18 months',
        ),
      ],
      tryIt: [
        'Compare a simple baseline with a more complex model.',
        'Explain what your model cannot conclude.',
      ],
    ),
    _career(
      title: 'Cybersecurity Analyst',
      summary: 'Help organizations protect systems, people, and information.',
      category: 'Technology',
      glyph: CareerGlyph.intelligence,
      color: 0xFF72D8A4,
      skills: [
        'Networking',
        'Operating systems',
        'Risk awareness',
        'Clear reporting',
      ],
      education:
          'IT, networking, or security study helps. Use only authorized labs; never test systems without written permission.',
      steps: [
        _step(
          'Build IT foundations',
          'Learn computer hardware, networking, operating systems, and basic scripting.',
          '2-5 months',
        ),
        _step(
          'Practice safely',
          'Use legal training labs and learn defensive monitoring, access control, and incident basics.',
          '3-8 months',
        ),
        _step(
          'Show defensive skills',
          'Write a sample incident report and document a home-lab monitoring exercise without real targets.',
          '4-10 months',
        ),
        _step(
          'Gain experience',
          'Seek an IT help-desk internship, security placement, or entry-level analyst role; check local certification value.',
          '6-18 months',
        ),
      ],
      tryIt: [
        'Complete a beginner defensive-security lab.',
        'Write a plain-language guide to securing an account.',
      ],
    ),
    _career(
      title: 'AI / ML Engineer',
      summary:
          'Build, evaluate, and maintain systems that use machine learning.',
      category: 'Technology',
      glyph: CareerGlyph.intelligence,
      color: 0xFF72D8A4,
      skills: [
        'Programming',
        'Statistics',
        'Machine learning',
        'Responsible AI',
      ],
      education:
          'Computer science, mathematics, or engineering study helps; hiring teams expect strong software and evaluation skills.',
      steps: [
        _step(
          'Strengthen math and software basics',
          'Learn Python, data structures, probability, linear algebra, and version control.',
          '3-8 months',
        ),
        _step(
          'Study machine learning',
          'Understand supervised learning, evaluation, data leakage, and limitations before using advanced models.',
          '3-8 months',
        ),
        _step(
          'Build and document projects',
          'Train a small model on appropriate data, compare baselines, document risks, and deploy a demo.',
          '4-10 months',
        ),
        _step(
          'Gain engineering experience',
          'Contribute to a research or software team and apply for internships or junior ML roles.',
          '6-18 months',
        ),
      ],
      tryIt: [
        'Reproduce a beginner model using an open dataset.',
        'Write a short model card describing limitations and intended use.',
      ],
    ),
    _career(
      title: 'UX / Product Designer',
      summary: 'Research needs and design accessible, useful experiences.',
      category: 'Design & Creative',
      glyph: CareerGlyph.design,
      color: 0xFFFFA76B,
      skills: [
        'Research',
        'Prototyping',
        'Accessibility',
        'Visual communication',
      ],
      education:
          'A design degree can help, but a thoughtful portfolio and evidence of user-centered practice are important.',
      steps: [
        _step(
          'Learn design foundations',
          'Study visual hierarchy, accessibility, interaction patterns, and basic research ethics.',
          '1-3 months',
        ),
        _step(
          'Practice with prototypes',
          'Interview consenting users, map a task, and prototype a small solution in a design tool.',
          '2-5 months',
        ),
        _step(
          'Create case studies',
          'Show the problem, research, iterations, accessibility decisions, and what you learned.',
          '3-8 months',
        ),
        _step(
          'Get feedback and apply',
          'Request portfolio reviews, collaborate with developers, and apply for internships or junior roles.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Improve a confusing everyday task and test your prototype with users.',
        'Make an existing page easier to use with a keyboard.',
      ],
    ),
    _career(
      title: 'UX Designer',
      summary: 'Make digital products easier and more intuitive to use.',
      category: 'Design & Creative',
      glyph: CareerGlyph.design,
      color: 0xFFFFA76B,
      skills: [
        'User research',
        'Interaction design',
        'Prototyping',
        'Accessibility',
      ],
      education:
          'A design degree can help, but a portfolio with well-explained research and iteration is often central to hiring.',
      steps: [
        _step(
          'Learn research and usability',
          'Study interview methods, usability testing, accessibility, and interaction principles.',
          '1-3 months',
        ),
        _step(
          'Practice design tools',
          'Map user flows and create low- and high-fidelity prototypes for a focused problem.',
          '2-5 months',
        ),
        _step(
          'Write thoughtful case studies',
          'Explain the context, research, iterations, accessibility, and what you would improve next.',
          '3-8 months',
        ),
        _step(
          'Get critique and apply',
          'Ask designers and users for feedback, collaborate with developers, and apply for internships or junior roles.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Test a prototype with a few consenting people.',
        'Include accessibility checks in a design case study.',
      ],
    ),
    _career(
      title: 'Teacher / Educator',
      summary: 'Help learners build knowledge, skills, and confidence.',
      category: 'Education',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: ['Subject knowledge', 'Communication', 'Planning', 'Patience'],
      education:
          'Teaching credentials, background checks, and subject requirements vary by country, age group, and school. Verify your local regulator.',
      steps: [
        _step(
          'Choose a subject and age group',
          'Explore curriculum requirements and talk with teachers about classroom responsibilities.',
          '1-2 months',
        ),
        _step(
          'Build subject and teaching foundations',
          'Study the subject and complete the locally recognized teacher-training route.',
          '1-4 years',
        ),
        _step(
          'Practice with learners',
          'Tutor or volunteer in an approved setting, request supervision, and reflect on feedback.',
          'Alongside study',
        ),
        _step(
          'Qualify and apply',
          'Complete required placements, checks, and registration before applying to schools.',
          'As required locally',
        ),
      ],
      tryIt: [
        'Plan a short lesson and teach it to a willing peer group.',
        'Volunteer only through an approved youth or education program.',
      ],
    ),
    _career(
      title: 'Nurse',
      summary: 'Provide compassionate, evidence-based care to patients.',
      category: 'Healthcare',
      glyph: CareerGlyph.intelligence,
      color: 0xFF72D8A4,
      skills: [
        'Care and empathy',
        'Clinical communication',
        'Teamwork',
        'Attention to detail',
      ],
      education:
          'Nursing is a regulated profession: an approved nursing program, supervised clinical placements, and local registration are typically required.',
      steps: [
        _step(
          'Check local entry requirements',
          'Contact the nursing regulator and approved schools about prerequisites, costs, placements, and checks.',
          '1-3 months',
        ),
        _step(
          'Complete an approved program',
          'Study nursing science and complete supervised clinical training in approved settings.',
          'Program length varies',
        ),
        _step(
          'Register and build experience',
          'Pass required assessments, obtain registration, and begin with supported clinical practice.',
          'As required locally',
        ),
        _step(
          'Continue learning',
          'Maintain registration and pursue supervised specialties based on your interests and patient needs.',
          'Ongoing',
        ),
      ],
      tryIt: [
        'Speak with a registered nurse about their day-to-day work.',
        'Explore approved first-aid or community health education.',
      ],
    ),
    _career(
      title: 'Accountant',
      summary:
          'Help people and organizations understand financial records and obligations.',
      category: 'Business & Finance',
      glyph: CareerGlyph.data,
      color: 0xFF9C83FF,
      skills: ['Numeracy', 'Accuracy', 'Ethics', 'Communication'],
      education:
          'Accounting study is common. Professional titles, audit work, and signing authority may require local exams, supervised experience, or licensing.',
      steps: [
        _step(
          'Learn accounting basics',
          'Study bookkeeping, financial statements, spreadsheets, and business ethics.',
          '1-4 months',
        ),
        _step(
          'Build practical skills',
          'Practice reconciliations and sample reports using fictional or public data.',
          '2-6 months',
        ),
        _step(
          'Choose a qualification route',
          'Compare recognized local accounting bodies, exam requirements, costs, and supervised experience.',
          '3-8 months',
        ),
        _step(
          'Get supervised experience',
          'Apply for finance assistant roles, internships, or trainee programs and continue required study.',
          '6-24 months',
        ),
      ],
      tryIt: [
        'Prepare a simple budget and cash-flow example for a fictional small business.',
        'Ask a local accountant about entry routes.',
      ],
    ),
    _career(
      title: 'Marketing Specialist',
      summary: 'Connect audiences with useful products, services, or causes.',
      category: 'Business & Marketing',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: ['Writing', 'Audience research', 'Analytics', 'Creativity'],
      education:
          'Marketing, communications, or business study is useful; a portfolio showing ethical, measurable work can also demonstrate readiness.',
      steps: [
        _step(
          'Learn audience and channel basics',
          'Study customer research, positioning, writing, accessibility, and privacy-aware marketing.',
          '1-3 months',
        ),
        _step(
          'Practice a channel',
          'Choose content, email, events, or search; plan a small campaign with clear goals and consent.',
          '2-5 months',
        ),
        _step(
          'Measure and explain outcomes',
          'Build sample work and use meaningful metrics; be honest about what you did and what changed.',
          '3-8 months',
        ),
        _step(
          'Get experience and specialize',
          'Support a club or nonprofit campaign and apply for internships or coordinator roles.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Create a content plan for a student club with permission.',
        'Compare two public campaigns and explain their audience choices.',
      ],
    ),
    _career(
      title: 'Human Resources Coordinator',
      summary:
          'Support fair hiring, employee services, and workplace operations.',
      category: 'Business & People',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: [
        'Listening',
        'Organization',
        'Confidentiality',
        'Employment basics',
      ],
      education:
          'Business, HR, or psychology study can help; learn local employment law and handle personal information carefully.',
      steps: [
        _step(
          'Learn people-operations basics',
          'Study recruitment, onboarding, record keeping, inclusion, and confidentiality.',
          '1-3 months',
        ),
        _step(
          'Understand local requirements',
          'Learn foundational employment rules and data-protection practices for your region.',
          '2-4 months',
        ),
        _step(
          'Build evidence',
          'Practice scheduling, clear policy writing, and fair interview questions in a class or volunteer setting.',
          '3-6 months',
        ),
        _step(
          'Apply for entry roles',
          'Seek HR assistant internships or coordinator roles and pursue relevant local professional learning.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Design an accessible onboarding checklist for a fictional team.',
        'Practice structured, job-related interview questions.',
      ],
    ),
    _career(
      title: 'Product Manager',
      summary: 'Help teams choose what to build and measure its impact.',
      category: 'Business & Operations',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: [
        'Customer research',
        'Prioritization',
        'Communication',
        'Analysis',
      ],
      education:
          'There is no single required degree; product, business, design, or technical experience can provide useful foundations.',
      steps: [
        _step(
          'Learn product fundamentals',
          'Study customer discovery, problem framing, prioritization, and product ethics.',
          '1-3 months',
        ),
        _step(
          'Practice clear planning',
          'Write a concise product brief with a user problem, goals, constraints, and success measures.',
          '2-5 months',
        ),
        _step(
          'Work with a team',
          'Help a student or community team deliver a small feature and collect user feedback.',
          '3-8 months',
        ),
        _step(
          'Build evidence and apply',
          'Document decisions and outcomes; apply for associate product roles or transition from a related role.',
          '6-18 months',
        ),
      ],
      tryIt: [
        'Interview consenting users about a real problem.',
        'Draft a one-page product brief and request team feedback.',
      ],
    ),
    _career(
      title: 'Civil Engineer',
      summary:
          'Plan and deliver safe infrastructure such as buildings, roads, and water systems.',
      category: 'Engineering & Trades',
      glyph: CareerGlyph.code,
      color: 0xFF24D8FF,
      skills: ['Mathematics', 'Physics', 'Design', 'Safety'],
      education:
          'Accredited engineering study is commonly expected; protected titles and sign-off responsibilities may require local registration.',
      steps: [
        _step(
          'Strengthen math and science',
          'Build algebra, calculus, physics, technical drawing, and communication foundations.',
          'Before and during study',
        ),
        _step(
          'Complete accredited study',
          'Compare recognized civil-engineering programs and learn local accreditation requirements.',
          'Usually several years',
        ),
        _step(
          'Gain supervised experience',
          'Seek internships or placements and document safe, ethical project contributions.',
          'During and after study',
        ),
        _step(
          'Register and specialize',
          'Meet local professional requirements and develop expertise in areas such as transport, structures, or water.',
          'Varies by jurisdiction',
        ),
      ],
      tryIt: [
        'Explore a public infrastructure project and explain its constraints.',
        'Join a supervised engineering design or bridge-building challenge.',
      ],
    ),
    _career(
      title: 'Electrician',
      summary: 'Install, inspect, and repair electrical systems safely.',
      category: 'Engineering & Trades',
      glyph: CareerGlyph.code,
      color: 0xFF24D8FF,
      skills: [
        'Practical problem solving',
        'Safety',
        'Precision',
        'Customer communication',
      ],
      education:
          'A recognized apprenticeship or vocational program, supervised hours, and local licensing are commonly required. Never practice on live systems.',
      steps: [
        _step(
          'Check the local trade route',
          'Find official apprenticeship, school, safety, and licensing requirements in your area.',
          '1-2 months',
        ),
        _step(
          'Learn core theory safely',
          'Study electrical fundamentals, regulations, tools, and hazard awareness through an approved course.',
          'Program dependent',
        ),
        _step(
          'Complete supervised training',
          'Apply for a recognized apprenticeship and complete required classroom and supervised work hours.',
          'Usually several years',
        ),
        _step(
          'Qualify and keep learning',
          'Pass required assessments, obtain authorization, and keep up with updated safety rules.',
          'As required locally',
        ),
      ],
      tryIt: [
        'Visit a vocational open day and ask about apprenticeship placements.',
        'Study basic electrical safety; do not attempt wiring or repair work.',
      ],
    ),
    _career(
      title: 'Graphic Designer',
      summary:
          'Create clear visual identities and communication for people and organizations.',
      category: 'Design & Creative',
      glyph: CareerGlyph.design,
      color: 0xFFFFA76B,
      skills: [
        'Visual design',
        'Typography',
        'Accessibility',
        'Client communication',
      ],
      education:
          'Design study can build foundations; employers often assess a portfolio, process, and ability to respond to feedback.',
      steps: [
        _step(
          'Learn visual foundations',
          'Practice typography, layout, color, composition, and accessible contrast.',
          '1-3 months',
        ),
        _step(
          'Learn industry tools',
          'Use a design tool to create work for print and digital formats; follow licensing rules for assets.',
          '2-5 months',
        ),
        _step(
          'Build a focused portfolio',
          'Create three brief-led projects and explain your choices, constraints, and revisions.',
          '3-8 months',
        ),
        _step(
          'Get feedback and paid practice',
          'Take on clearly scoped student or community work and apply for junior roles.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Redesign a public-information poster for readability.',
        'Create a visual identity concept for a fictional community event.',
      ],
    ),
    _career(
      title: 'Journalist / Reporter',
      summary:
          'Research, verify, and communicate accurate stories to the public.',
      category: 'Media & Communications',
      glyph: CareerGlyph.design,
      color: 0xFFFFA76B,
      skills: ['Research', 'Writing', 'Verification', 'Fairness'],
      education:
          'Journalism or communications study can help; strong reporting samples, ethical practice, and local media law knowledge matter.',
      steps: [
        _step(
          'Learn reporting fundamentals',
          'Practice interviewing with consent, source verification, clear writing, and media ethics.',
          '1-3 months',
        ),
        _step(
          'Publish careful sample work',
          'Report on accessible topics, verify claims, seek responses, and correct errors transparently.',
          '2-6 months',
        ),
        _step(
          'Build newsroom experience',
          'Contribute to a student publication or supervised local outlet and learn editing workflows.',
          '3-9 months',
        ),
        _step(
          'Apply and keep learning',
          'Prepare a portfolio, understand local media law, and apply for reporting or production placements.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Write a short, sourced explainer on a local issue.',
        'Ask an editor to review your accuracy and fairness.',
      ],
    ),
    _career(
      title: 'Environmental Scientist',
      summary:
          'Study ecosystems and use evidence to guide environmental decisions.',
      category: 'Science & Environment',
      glyph: CareerGlyph.data,
      color: 0xFF72D8A4,
      skills: [
        'Field methods',
        'Data analysis',
        'Scientific writing',
        'Teamwork',
      ],
      education:
          'A relevant science degree is common; some fieldwork, consultancy, and laboratory roles require specific training or permits.',
      steps: [
        _step(
          'Build science foundations',
          'Study biology, chemistry, ecology, statistics, and scientific communication.',
          'Before and during study',
        ),
        _step(
          'Learn research methods',
          'Practice safe field sampling, data management, mapping, and reproducible analysis.',
          'During study',
        ),
        _step(
          'Gain supervised experience',
          'Join a university lab, conservation project, or authorized field placement.',
          'During study',
        ),
        _step(
          'Choose a focus and apply',
          'Build a project portfolio and apply for assistant roles in consulting, research, or conservation.',
          'Final study years onward',
        ),
      ],
      tryIt: [
        'Volunteer with a reputable conservation group.',
        'Analyze a public environmental dataset and explain its limits.',
      ],
    ),
    _career(
      title: 'Social Worker',
      summary:
          'Support individuals and communities through challenging life situations.',
      category: 'Public & Community',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: ['Empathy', 'Boundaries', 'Advocacy', 'Case documentation'],
      education:
          'Social work is regulated in many places; an approved degree, placements, background checks, and registration may be required.',
      steps: [
        _step(
          'Learn about the profession',
          'Talk with practitioners and review local regulator requirements, ethics, and safety expectations.',
          '1-3 months',
        ),
        _step(
          'Complete approved education',
          'Choose a locally recognized social-work program with supervised field placements.',
          'Program length varies',
        ),
        _step(
          'Complete placements and registration',
          'Build practice under supervision and complete required checks, exams, or registration.',
          'As required locally',
        ),
        _step(
          'Start with supervision',
          'Apply to entry-level roles and continue reflective practice, supervision, and professional learning.',
          'Ongoing',
        ),
      ],
      tryIt: [
        'Explore supervised community volunteering with a reputable organization.',
        'Learn active listening without presenting yourself as a counselor.',
      ],
    ),
    _career(
      title: 'Chef / Culinary Professional',
      summary: 'Prepare food safely and create memorable dining experiences.',
      category: 'Hospitality & Tourism',
      glyph: CareerGlyph.design,
      color: 0xFFFFA76B,
      skills: ['Food safety', 'Time management', 'Teamwork', 'Creativity'],
      education:
          'Culinary school is optional in some markets; food-safety certification and local health requirements may apply.',
      steps: [
        _step(
          'Learn safe kitchen basics',
          'Study food hygiene, allergens, knife safety, and kitchen organization from trusted local guidance.',
          '1-2 months',
        ),
        _step(
          'Practice foundational techniques',
          'Build consistency with basic methods, recipes, timing, and portion planning.',
          '2-6 months',
        ),
        _step(
          'Get supervised kitchen experience',
          'Seek a legitimate kitchen placement or entry-level role with safe training and clear supervision.',
          '3-12 months',
        ),
        _step(
          'Build a specialty',
          'Collect feedback, document recipes and costs, and progress toward a station or team-lead role.',
          '1-3 years',
        ),
      ],
      tryIt: [
        'Plan and prepare a balanced meal while following food-safety guidance.',
        'Ask a local kitchen about a supervised entry route.',
      ],
    ),
    _career(
      title: 'Project Coordinator',
      summary:
          'Keep teams organized and help projects move from plan to delivery.',
      category: 'Business & Operations',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: ['Organization', 'Communication', 'Planning', 'Problem solving'],
      education:
          'Requirements vary by industry; project experience and clear communication can be as important as formal study.',
      steps: [
        _step(
          'Learn planning basics',
          'Practice defining goals, tasks, owners, risks, timelines, and meeting notes.',
          '1-2 months',
        ),
        _step(
          'Use everyday tools',
          'Learn spreadsheets and a project-tracking tool; keep plans accessible and up to date.',
          '1-3 months',
        ),
        _step(
          'Coordinate a small project',
          'Lead a student or community activity and record decisions, progress, and lessons learned.',
          '2-6 months',
        ),
        _step(
          'Apply and develop',
          'Show evidence of reliable delivery and explore industry-specific training as your experience grows.',
          '3-9 months',
        ),
      ],
      tryIt: [
        'Organize a small event with a written plan and retrospective.',
        'Create a sample timeline with risks and backup plans.',
      ],
    ),
    _career(
      title: 'Agriculture & Food Systems Specialist',
      summary:
          'Improve how food is grown, processed, and delivered sustainably.',
      category: 'Science & Environment',
      glyph: CareerGlyph.data,
      color: 0xFF72D8A4,
      skills: [
        'Biology',
        'Practical problem solving',
        'Sustainability',
        'Communication',
      ],
      education:
          'Routes include agriculture, environmental science, food science, and vocational training; requirements depend on the role.',
      steps: [
        _step(
          'Explore the food system',
          'Learn about soils, crops, animal welfare, water, supply chains, and local farming practices.',
          '1-3 months',
        ),
        _step(
          'Choose a practical focus',
          'Study a relevant subject and learn safe, locally appropriate field or laboratory methods.',
          '3-18 months',
        ),
        _step(
          'Gain field experience',
          'Seek supervised work with a farm, food organization, research group, or extension service.',
          'During study',
        ),
        _step(
          'Build a specialty',
          'Document a practical project and apply to technician, field-support, or graduate roles.',
          '6-24 months',
        ),
      ],
      tryIt: [
        'Visit an educational farm or food-system organization.',
        'Compare local seasonal produce and map its supply chain.',
      ],
    ),
    _career(
      title: 'Financial Planner',
      summary:
          'Help clients make informed decisions about personal financial goals.',
      category: 'Business & Finance',
      glyph: CareerGlyph.data,
      color: 0xFF9C83FF,
      skills: ['Numeracy', 'Listening', 'Ethics', 'Clear explanations'],
      education:
          'Financial advice is regulated in many regions; recognized qualifications, supervised experience, and authorization may be mandatory.',
      steps: [
        _step(
          'Learn personal-finance foundations',
          'Study budgeting, saving, risk, and financial ethics using reputable educational sources.',
          '1-3 months',
        ),
        _step(
          'Check regulator requirements',
          'Identify local qualifications, licensing, background checks, and permitted activities before advising anyone.',
          '1-2 months',
        ),
        _step(
          'Complete recognized training',
          'Follow an approved education route and seek supervised experience with an authorized organization.',
          'Varies locally',
        ),
        _step(
          'Qualify before advising',
          'Meet local authorization rules, maintain continuing education, and communicate risks transparently.',
          'As required locally',
        ),
      ],
      tryIt: [
        'Create a fictional household budget as an educational exercise.',
        'Interview an authorized planner about their training route.',
      ],
    ),
    _career(
      title: 'Lawyer / Legal Professional',
      summary:
          'Research rules and help people or organizations understand legal matters.',
      category: 'Law & Public Service',
      glyph: CareerGlyph.product,
      color: 0xFFFFC857,
      skills: ['Research', 'Writing', 'Reasoning', 'Professional ethics'],
      education:
          'Legal education, supervised practice, and admission requirements differ significantly by jurisdiction and role.',
      steps: [
        _step(
          'Explore legal careers',
          'Compare lawyer, paralegal, policy, and court-service roles and review your local regulator.',
          '1-3 months',
        ),
        _step(
          'Complete the required study',
          'Choose an education route recognized by the jurisdiction where you plan to work.',
          'Varies locally',
        ),
        _step(
          'Gain supervised experience',
          'Complete required placements, practical training, exams, or supervised practice.',
          'As required locally',
        ),
        _step(
          'Obtain authorization',
          'Meet local admission or certification rules before offering legal services; keep skills current.',
          'As required locally',
        ),
      ],
      tryIt: [
        'Join a supervised debate or mock-trial program.',
        'Practice summarizing a public legal decision using reliable sources.',
      ],
    ),
    _career(
      title: 'Operations & Supply Chain Analyst',
      summary:
          'Help organizations plan inventory, logistics, and reliable operations.',
      category: 'Business & Operations',
      glyph: CareerGlyph.data,
      color: 0xFF9C83FF,
      skills: [
        'Data analysis',
        'Planning',
        'Process improvement',
        'Communication',
      ],
      education:
          'Business, logistics, engineering, or analytics study can help; internships and process-improvement examples are valuable.',
      steps: [
        _step(
          'Understand how operations work',
          'Learn inventory, procurement, logistics, service processes, and basic business metrics.',
          '1-3 months',
        ),
        _step(
          'Build analytical skills',
          'Practice spreadsheets, SQL basics, forecasting concepts, and process mapping.',
          '2-5 months',
        ),
        _step(
          'Create a case study',
          'Use fictional or public data to identify a bottleneck and propose a measurable improvement.',
          '3-8 months',
        ),
        _step(
          'Gain experience and apply',
          'Seek operations internships and coordinator or analyst roles; learn industry-specific systems on the job.',
          '6-12 months',
        ),
      ],
      tryIt: [
        'Map the steps in a campus service and suggest one testable improvement.',
        'Build a simple inventory tracker with sample data.',
      ],
    ),
  ];

  final _store = CareerPreferencesStore();
  Set<String> _savedIds = <String>{};
  String _query = '';
  String _category = 'All';
  late bool _savedOnly;

  @override
  void initState() {
    super.initState();
    _savedOnly = widget.savedOnly;
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final ids = await _store.loadSavedRoleIds();
    if (mounted) setState(() => _savedIds = ids);
  }

  Future<void> _toggleSaved(CareerRole role) async {
    final ids = await _store.toggleSavedRole(role.id);
    if (mounted) setState(() => _savedIds = ids);
  }

  List<CareerRole> get _filteredRoles => roles.where((role) {
    final matchesQuery =
        _query.isEmpty ||
        '${role.title} ${role.summary} ${role.category} ${role.skills.join(' ')} ${role.education} ${role.tryIt.join(' ')}'
            .toLowerCase()
            .contains(_query.toLowerCase());
    final matchesCategory = _category == 'All' || role.category == _category;
    final matchesSaved = !_savedOnly || _savedIds.contains(role.id);
    return matchesQuery && matchesCategory && matchesSaved;
  }).toList();

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
    children: [
      const Text(
        'Jobs & career paths',
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 5),
      const Text(
        'Explore opportunities across industries and get a practical path to start.',
        style: TextStyle(color: _muted, fontSize: 12),
      ),
      const SizedBox(height: 8),
      const Text(
        'Training, licensing, pay, and job demand vary by location. Check local official requirements before choosing a course or profession.',
        style: TextStyle(color: _muted, fontSize: 11, height: 1.45),
      ),
      const SizedBox(height: 18),
      TextField(
        onChanged: (value) => setState(() => _query = value.trim()),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search jobs, fields, or skills',
          isDense: true,
        ),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final category in [
              'All',
              ...roles.map((role) => role.category).toSet(),
            ])
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: ChoiceChip(
                  label: Text(category),
                  selected: category == _category,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _category = category),
                ),
              ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: FilterChip(
          avatar: const Icon(Icons.bookmark_outline, size: 16),
          label: const Text('Saved roles'),
          selected: _savedOnly,
          onSelected: (value) => setState(() => _savedOnly = value),
        ),
      ),
      const SizedBox(height: 12),
      Text(
        '${_filteredRoles.length} career${_filteredRoles.length == 1 ? '' : 's'} to explore',
        style: const TextStyle(color: _muted, fontSize: 11),
      ),
      const SizedBox(height: 8),
      if (_filteredRoles.isEmpty)
        const AppPanel(
          child: Text(
            'No roles match these filters.',
            style: TextStyle(color: _muted),
          ),
        ),
      ..._filteredRoles.map(
        (role) => _RoleCard(
          role: role,
          isSaved: _savedIds.contains(role.id),
          onToggleSaved: () => _toggleSaved(role),
        ),
      ),
    ],
  );
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.isSaved,
    required this.onToggleSaved,
  });

  final CareerRole role;
  final bool isSaved;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final color = Color(role.colorValue);
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: _panel,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => showModalBottomSheet<void>(
            context: context,
            backgroundColor: _panel,
            isScrollControlled: true,
            builder: (_) => _RoleDetails(role: role),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CareerPhoto(
                      imageUrl: role.imageUrl,
                      icon: _careerIcon(role.glyph),
                      color: color,
                      height: 120,
                    ),
                    Positioned(
                      right: 7,
                      top: 7,
                      child: IconButton.filledTonal(
                        tooltip: isSaved ? 'Remove saved role' : 'Save role',
                        onPressed: onToggleSaved,
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color.withValues(alpha: .13),
                      child: Icon(
                        _careerIcon(role.glyph),
                        color: color,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            role.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            role.category,
                            style: const TextStyle(color: _cyan, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: _muted, size: 19),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  role.summary,
                  style: const TextStyle(color: _muted, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Text(
                  '${role.skills.take(3).join(' · ')}  ·  ${role.roadmap.length} roadmap steps',
                  style: const TextStyle(color: _muted, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleDetails extends StatelessWidget {
  const _RoleDetails({required this.role});

  final CareerRole role;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          22,
          24,
          22,
          22 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _careerIcon(role.glyph),
              color: Color(role.colorValue),
              size: 30,
            ),
            const SizedBox(height: 12),
            Text(
              role.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 7),
            Text(role.summary, style: const TextStyle(color: _muted)),
            const SizedBox(height: 16),
            Text(
              role.category,
              style: const TextStyle(color: _cyan, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            const Text(
              'Education and entry requirements',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 7),
            Text(
              role.education,
              style: const TextStyle(color: _muted, height: 1.45),
            ),
            const SizedBox(height: 18),
            const Text(
              'Key skills',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 9),
            Wrap(
              spacing: 8,
              children: [...role.skills.map((skill) => SkillPill(skill))],
            ),
            const SizedBox(height: 18),
            const Text(
              'Ways to explore this career',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 7),
            ...role.tryIt.map(
              (idea) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: _cyan,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        idea,
                        style: const TextStyle(color: _muted, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            PrimaryButton(
              label: 'Open step-by-step roadmap',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => RoadmapScreen(role: role),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}

IconData _careerIcon(CareerGlyph glyph) => switch (glyph) {
  CareerGlyph.code => Icons.terminal,
  CareerGlyph.data => Icons.insights,
  CareerGlyph.design => Icons.draw_outlined,
  CareerGlyph.intelligence => Icons.memory,
  CareerGlyph.product => Icons.view_kanban_outlined,
};
