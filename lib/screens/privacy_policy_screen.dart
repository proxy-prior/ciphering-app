import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/glass_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      body: GradientBackground(
        useAurora: false,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Row(
                  children: [
                    IconButtonCircle(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text('Privacy Policy', style: AppTheme.pageTitle)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Last updated: May 2026',
                        style: AppTheme.caption,
                      ),
                      const SizedBox(height: 16),
                      _section('1. Introduction', [
                        'Ciphering (Service) is a privacy and communication management platform operated by Sqewes Private Limited (Operator, We, Us). Ciphering helps Users stay reachable without sharing their personal mobile number by providing managed alias phone numbers.',
                        'This Privacy Policy explains what information We collect when You use Ciphering, how We use and protect it, whom We share it with, and what rights You have regarding Your personal data.',
                        'Ciphering is not an anonymity service. Every account is verified through government-approved DigiLocker eKYC, and every Alias Number is traceable to its verified account holder. The Operator maintains full records of number ownership and cooperates with law enforcement and regulatory authorities as required by law.',
                        'By using the Service, You consent to the collection and use of Your information as described in this Policy. This Policy should be read together with the Terms and Conditions.',
                        'This Policy is published in compliance with the Information Technology Act, 2000 (as amended), the Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Data or Information) Rules, 2011, and, to the extent applicable, the Digital Personal Data Protection Act, 2023 (DPDPA).',
                      ]),
                      _section('2. Information We Collect', []),
                      _subsection('2.1 Information You Provide'),
                      _bulletList([
                        'Full name, email address, and date of birth provided during account registration.',
                        'Mobile phone number (Primary Number) used for OTP verification and call/SMS forwarding.',
                        'Identity information verified through DigiLocker eKYC (such as Aadhaar-linked name and date of birth). We do not store Aadhaar numbers; verification is performed via DigiLocker\u2019s APIs and only a confirmation of successful verification is retained.',
                        'Purpose labels and preferences You assign to each Alias Number.',
                        'Communications You send to our support team.',
                      ]),
                      _subsection('2.2 Information Collected Automatically'),
                      _bulletList([
                        'Device information: device model, operating system version, unique device identifiers, and app version.',
                        'Usage data: timestamps of account creation, alias creation, activation, pause, and deletion events; frequency of calls received; call durations; and in-app navigation patterns.',
                        'Network information: IP address, mobile carrier, and connection type (Wi-Fi or cellular) at the time of app access.',
                        'Crash reports and performance logs for debugging and service improvement.',
                      ]),
                      _subsection('2.3 Information from Telecom Partners'),
                      _bulletList([
                        'Call detail records (CDRs): caller number, alias number, call start time, call duration, and call status (answered, missed, blocked).',
                        'Inbound SMS metadata: sender number, alias number, and timestamp. SMS content is displayed in-app but is not permanently stored on our servers beyond the retention period described in Section 5.',
                        'We do not record call audio unless the User explicitly activates a call recording feature (if offered in a paid tier) and all parties are notified in accordance with applicable law.',
                      ]),
                      _subsection('2.4 Information We Do Not Collect'),
                      _bulletList([
                        'We do not collect the content of phone conversations (unless call recording is explicitly activated by the User).',
                        'We do not store Aadhaar numbers. Only a verification status flag and DigiLocker-provided name and date of birth are retained.',
                        'We do not collect location data, contacts, photos, or other device data beyond what is described above.',
                      ]),
                      _section('3. How We Use Your Information', [
                        'We use the information We collect for the following purposes:',
                      ]),
                      _bulletList([
                        'To provision, route, and manage Alias Numbers and forward inbound calls and SMS to Your Primary Number.',
                        'To verify Your identity through DigiLocker eKYC and fulfil regulatory KYC obligations.',
                        'To maintain number ownership records that map every Alias Number to its verified account holder.',
                        'To maintain, troubleshoot, and improve the performance, security, and reliability of the Service.',
                        'To detect, investigate, and prevent fraud, abuse, spam, and violations of our Terms and Conditions.',
                        'To comply with applicable laws, regulations, court orders, and lawful requests from government authorities.',
                        'To communicate with You regarding account status, service updates, security alerts, and support responses.',
                        'To generate aggregated, de-identified analytics to understand usage patterns and improve the Service.',
                      ]),
                      _bodyText(
                          'We do not use Your personal data for targeted advertising. We do not sell, rent, or trade Your personal information to advertisers, data brokers, or any third party for marketing purposes.'),
                      const SizedBox(height: 16),
                      _section('4. Data Sharing and Disclosure', [
                        'We may share Your information with the following categories of recipients, and only to the extent necessary for the stated purposes:',
                      ]),
                      _subsection('Telecom Partners'),
                      _bodyText(
                          'Licensed telephony providers who provision Alias Numbers and route calls and SMS. These partners receive the minimum data necessary for call/SMS routing.'),
                      const SizedBox(height: 8),
                      _subsection('Infrastructure and Service Providers'),
                      _bodyText(
                          'Cloud hosting providers, analytics services, crash reporting tools, and other technical vendors. These providers are bound by data processing agreements that restrict their use of Your data.'),
                      const SizedBox(height: 8),
                      _subsection('Payment Processors'),
                      _bodyText(
                          'Where You purchase a paid plan, Your payment is handled by a third-party payment gateway. We do not store Your full payment card details.'),
                      const SizedBox(height: 8),
                      _subsection('Law Enforcement and Regulatory Authorities'),
                      _bodyText(
                          'We will disclose Your information when required to do so by law, by a court order, or by a lawful request from a government or regulatory authority.'),
                      const SizedBox(height: 8),
                      _bodyText(
                          'In the event of a merger, acquisition, reorganisation, or sale of assets, Your information may be transferred to the successor entity, which will be bound by this Privacy Policy until it is superseded.'),
                      const SizedBox(height: 16),
                      _section('5. Data Retention', [
                        'We retain Your personal data only for as long as reasonably necessary to fulfil the purposes for which it was collected, including:',
                      ]),
                      _bulletList([
                        'Account data (name, email, phone): retained for the duration of Your active account, plus up to 180 days after account deletion.',
                        'KYC verification status: retained for the duration of Your account plus any period required by telecom or financial regulations.',
                        'Number ownership records: retained for the duration required by applicable telecom regulations, even after account deletion.',
                        'Call detail records and SMS metadata: retained for up to 12 months from the date of the communication.',
                        'Crash logs and de-identified analytics: retained indefinitely in aggregate form.',
                      ]),
                      _bodyText(
                          'Upon account deletion, We will delete or de-identify Your personal data within a reasonable time, except where retention is required for legal compliance, fraud prevention, or the enforcement of our Terms.'),
                      const SizedBox(height: 16),
                      _section('6. Data Security', [
                        'We implement reasonable technical and organisational security measures to protect Your information, including:',
                      ]),
                      _bulletList([
                        'Encryption of data in transit using TLS 1.2 or higher.',
                        'Encryption of sensitive data at rest.',
                        'Access controls restricting employee and contractor access on a need-to-know basis.',
                        'Regular security audits and vulnerability assessments.',
                        'Secure authentication mechanisms for User accounts.',
                      ]),
                      _bodyText(
                          'While We take reasonable precautions, no system is completely secure. In the event of a data breach, We will notify affected Users and relevant authorities in accordance with applicable law.'),
                      const SizedBox(height: 16),
                      _section('7. Your Rights', [
                        'Subject to applicable law, You have the following rights:',
                      ]),
                      _bulletList([
                        'Right to Access \u2014 Request a summary of the personal data We hold about You.',
                        'Right to Correction \u2014 Request correction of inaccurate or incomplete data.',
                        'Right to Erasure \u2014 Request deletion of Your personal data by deleting Your account.',
                        'Right to Data Portability \u2014 Request a copy of Your data in a machine-readable format.',
                        'Right to Withdraw Consent \u2014 Withdraw consent at any time without affecting prior processing.',
                        'Right to Nominate \u2014 Under the DPDPA, nominate another individual to exercise Your rights.',
                      ]),
                      _bodyText(
                          'To exercise any of these rights, contact Us at ciphering.app@gmail.com. We will respond within 30 days.'),
                      const SizedBox(height: 16),
                      _section('8. Children\u2019s Privacy', [
                        'The Service is intended exclusively for Users aged 18 years or older. We do not knowingly collect personal data from anyone under the age of 18. If We become aware that a minor has provided personal information, We will take reasonable steps to delete such data promptly.',
                      ]),
                      _section('9. Cookies and Tracking', [
                        'The Ciphering mobile application does not use browser cookies. However, the app may use device identifiers, analytics SDKs, and crash-reporting tools that collect device-level information. You may limit certain tracking through Your device\u2019s operating system settings.',
                      ]),
                      _section('10. Cross-Border Data Transfers', [
                        'Your data is primarily processed and stored within India. However, certain infrastructure providers may process data in jurisdictions outside India. Where cross-border transfers occur, We ensure adequate safeguards are in place, including contractual clauses and compliance with data localisation requirements.',
                      ]),
                      _section('11. Changes to This Policy', [
                        'We may update this Privacy Policy from time to time. Where changes materially affect how We process Your personal data, We will notify You via in-app notification, email, or SMS at least fifteen (15) days before the change takes effect. Continued use of the Service after the effective date constitutes acceptance of the revised Policy.',
                      ]),
                      _section('12. Grievance Officer and Contact', []),
                      GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grievance Officer',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _contactRow(Icons.person_outline, 'Danvish Muthu'),
                            const SizedBox(height: 4),
                            _contactRow(
                                Icons.email_outlined, 'ciphering.app@gmail.com'),
                            const SizedBox(height: 4),
                            _contactRow(Icons.location_on_outlined,
                                'Sqewes Private Limited, Bengaluru, Karnataka, India'),
                            const SizedBox(height: 12),
                            Text(
                              'We will acknowledge Your complaint within 48 hours and endeavour to resolve it within 30 days.',
                              style: AppTheme.caption.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'By using Ciphering, You confirm that You have read, understood, and agreed to this Privacy Policy.',
                        style: AppTheme.bodySmall.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _section(String title, List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.32,
          ),
        ),
        const SizedBox(height: 8),
        ...paragraphs.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                p,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            )),
      ],
    );
  }

  static Widget _subsection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  static Widget _bodyText(String text) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: 13,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
    );
  }

  static Widget _bulletList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.textTertiary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  static Widget _contactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
