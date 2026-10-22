part of '../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isSignup});

  final bool isSignup;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController(text: '+92');
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _api = AuthApi();
  final _userApi = UserApi();
  bool _busy = false;
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final result = widget.isSignup
          ? await _api.signup(
              fullName: _name.text.trim(),
              phoneNumber: _phone.text.trim(),
              email: _email.text.trim(),
              password: _password.text,
            )
          : await _api.login(_email.text.trim(), _password.text);
      final token = result['token']?.toString();
      if (token == null || token.isEmpty) {
        if (!mounted) return;
        showMessage(
          context,
          widget.isSignup
              ? 'Account created. Log in to continue.'
              : 'The API did not return an access token.',
        );
        if (widget.isSignup) Navigator.of(context).pop();
        return;
      }
      final refreshToken = result['refreshToken']?.toString();
      final profile = await _userApi.currentUser(token);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => profile['onboardingCompleted'] == true
              ? HomeShell(
                  token: token,
                  refreshToken: refreshToken,
                  profile: profile,
                )
              : ProfileSetupScreen(
                  token: token,
                  refreshToken: refreshToken,
                  profile: profile,
                ),
        ),
        (_) => false,
      );
    } catch (error) {
      if (mounted) showMessage(context, readableError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<String?> _requestText(
    String title,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) async {
    final controller = TextEditingController();
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _panel,
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
    controller.dispose();
    return value;
  }

  Future<void> _recoverPassword() async {
    final enteredEmail = validateEmail(_email.text) == null
        ? _email.text.trim()
        : await _requestText(
            'Reset your password',
            'Email address',
            keyboardType: TextInputType.emailAddress,
          );
    if (enteredEmail == null || validateEmail(enteredEmail) != null) return;
    setState(() => _busy = true);
    try {
      await _api.forgotPassword(enteredEmail);
      if (!mounted) return;
      final code = await _requestText(
        'Check your email',
        'Verification code',
        keyboardType: TextInputType.number,
      );
      if (code == null || code.isEmpty || !mounted) return;
      final verification = await _api.verifyResetCode(
        email: enteredEmail,
        code: code,
      );
      final ticket = verification['resetTicket']?.toString();
      if (ticket == null || ticket.isEmpty) {
        throw const FormatException('The API did not return a reset ticket.');
      }
      final password = await _requestText(
        'Create a new password',
        'New password (8+ characters)',
        obscureText: true,
      );
      if (password == null || password.length < 8 || !mounted) return;
      await _api.resetPassword(resetTicket: ticket, newPassword: password);
      if (mounted) {
        showMessage(context, 'Password updated. You can log in now.');
      }
    } catch (error) {
      if (mounted) {
        showMessage(context, readableError(error));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signup = widget.isSignup;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      signup ? 'Create account' : 'Welcome back!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      signup
                          ? 'Start building a career that fits you.'
                          : 'Log in to continue your journey.',
                      style: const TextStyle(color: _muted),
                    ),
                    const SizedBox(height: 28),
                    if (signup) ...[
                      const FieldLabel('Full name'),
                      TextFormField(
                        controller: _name,
                        textCapitalization: TextCapitalization.words,
                        validator: validateFullName,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: 'Your full name',
                        ),
                      ),
                      const SizedBox(height: 17),
                      const FieldLabel('Phone number'),
                      TextFormField(
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        validator: validatePhoneNumber,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_outlined),
                          hintText: '+923001234567',
                        ),
                      ),
                      const SizedBox(height: 17),
                    ],
                    const FieldLabel('Email'),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline),
                        hintText: 'you@example.com',
                      ),
                    ),
                    const SizedBox(height: 17),
                    const FieldLabel('Password'),
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: signup
                            ? 'Create a strong password'
                            : 'Enter your password',
                        suffixIcon: IconButton(
                          tooltip: _obscure ? 'Show password' : 'Hide password',
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    if (!signup)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _busy ? null : _recoverPassword,
                          child: const Text('Forgot password?'),
                        ),
                      )
                    else
                      const SizedBox(height: 24),
                    PrimaryButton(
                      label: signup ? 'Create account' : 'Log in',
                      busy: _busy,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) => AuthScreen(isSignup: !signup),
                          ),
                        ),
                        child: Text(
                          signup
                              ? 'Already have an account?  Log in'
                              : 'New here?  Create an account',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
