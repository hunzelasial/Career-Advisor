# Career Advisor

A Flutter career-guidance app with onboarding, account access, career recommendations, market insights, a roadmap, and a career-assistant chat. Career photos load from Unsplash and use in-app fallbacks when unavailable.

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

The API client targets `https://130.210.46.232.sslip.io`. Its Swagger contract is for EasyEstate: authentication, password recovery, profile, notification preferences, and logout endpoints are connected. Career recommendations, salary/growth snapshots, roadmap content, and assistant replies are illustrative local content because the API does not expose career-advisor endpoints.

Saved careers, the career goal, roadmap checkmarks, and chat history persist locally with `shared_preferences`.
