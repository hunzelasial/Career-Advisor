# Career Advisor

A Flutter career-guidance app with onboarding, account access, career-path exploration, internship search and a local application tracker, a CV builder, skill-gap self-assessment, interview practice, an aptitude reflection quiz, learning challenges, and university guidance. Career roles include entry guidance, practical starter ideas, and a progress-tracked roadmap. Google Search opens externally for live internship, university, and market research; the app does not scrape Google or present search results as structured API data. Market charts and career content in the app are illustrative, not live vacancies or personalized labor-market predictions. Career photos load from Unsplash and use in-app fallbacks when unavailable.

## Run

```powershell
flutter pub get
flutter run
```

## Source Layout

- `lib/pages/` contains one screen per file.
- `lib/widgets/` contains shared UI components.
- `lib/apis/` separates HTTP transport, authentication, and user-profile endpoints.
- `lib/models/` contains career and chat models.
- `lib/exceptions/` and `lib/utils/` contain API errors and form/error helpers.

The API client targets `https://130.210.46.232.sslip.io`. Its Swagger contract is for EasyEstate: authentication, password recovery, profile, notification preferences, and logout endpoints are connected. Job paths, roadmap content, market snapshots, and assistant replies are illustrative local content because the API does not expose career-advisor endpoints. Check official local education, licensing, and registration requirements for regulated careers.

Saved careers, internship tracking, the career goal, roadmap checkmarks, learning challenge progress, and chat history persist locally with `shared_preferences`.
