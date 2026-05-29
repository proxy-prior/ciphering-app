import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/icon_button_circle.dart';
import '../widgets/glass_card.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
                        child: Text('Terms & Conditions',
                            style: AppTheme.pageTitle)),
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
                      _section('1. Definitions and Interpretation', [
                        'In these Terms and Conditions (Terms), unless the context requires otherwise:',
                      ]),
                      _definitionList([
                        [
                          'Ciphering / Service',
                          'The privacy and communication management platform operated as a brand of Sqewes Private Limited, accessible via the Ciphering mobile application.'
                        ],
                        [
                          'Operator / We / Us',
                          'Sqewes Private Limited, a company incorporated under the laws of India, with its registered office in Bengaluru, Karnataka.'
                        ],
                        [
                          'User / You',
                          'Any individual who registers for, accesses, or uses the Service.'
                        ],
                        [
                          'Alias Number',
                          'A managed virtual phone number provisioned through the Service that forwards inbound calls and SMS to a User\u2019s registered Primary Number. Fully traceable to the verified account holder.'
                        ],
                        [
                          'Primary Number',
                          'The User\u2019s personal mobile number, registered with the Service and verified via OTP.'
                        ],
                        [
                          'Telecom Partner',
                          'Any licensed telecommunications operator or cloud telephony provider engaged by the Operator to provision and route Alias Numbers.'
                        ],
                        [
                          'KYC',
                          'Know Your Customer verification, conducted through DigiLocker or any equivalent government-approved mechanism.'
                        ],
                      ]),
                      _bodyText(
                          'These Terms constitute a legally binding agreement between You and the Operator. By creating an account, completing KYC verification, or using any feature of the Service, You acknowledge that You have read, understood, and agree to be bound by these Terms and our Privacy Policy.'),
                      const SizedBox(height: 16),
                      _section('2. Service Description and Purpose', [
                        'Ciphering is a privacy and communication management platform. It allows verified Users to create dedicated alias phone numbers for different areas of everyday life, such as marketplace listings, deliveries, freelance engagements, service bookings, and temporary interactions.',
                      ]),
                      _bodyText('The Service enables Users to:'),
                      const SizedBox(height: 4),
                      _bulletList([
                        'Receive inbound calls from third parties, forwarded to the User\u2019s Primary Number.',
                        'Receive inbound SMS messages in a read-only in-app inbox.',
                        'Create dedicated numbers for different contexts to organise communications.',
                        'Reduce unwanted calls and spam by keeping their Primary Number private.',
                      ]),
                      _bulletList([
                        'The Service is inbound-only. Users cannot place outbound calls or send outbound SMS from an Alias Number.',
                        'Ciphering is not an anonymity service. Every Alias Number is traceable to a KYC-verified account holder.',
                        'The Service is designed for use within India with +91 mobile numbers.',
                        'Ciphering may offer free and paid tiers with disclosed features and pricing.',
                      ]),
                      _section('3. Compliance and Safety Features', [
                        'The Service is built with regulatory compliance and user safety at its core:',
                      ]),
                      _bulletList([
                        'Mandatory identity verification through DigiLocker before receiving any Alias Number.',
                        'Complete, auditable number ownership tracking for every Alias Number.',
                        'Automated and manual abuse detection systems.',
                        'Reporting and blocking tools for unwanted callers.',
                        'Full cooperation with law enforcement and regulatory authorities.',
                        'All Alias Numbers provisioned through licensed Indian telecommunications providers under DoT regulations.',
                      ]),
                      _section('4. Eligibility and Registration', [
                        'To use the Service, You must:',
                      ]),
                      _bulletList([
                        'Be at least 18 years of age.',
                        'Be a resident of India and hold a valid Indian mobile number.',
                        'Successfully complete identity verification through DigiLocker eKYC.',
                        'Provide accurate, current, and complete information during registration.',
                      ]),
                      _bodyText(
                          'Each User may register only one account. Duplicate or fraudulent accounts will be terminated.'),
                      const SizedBox(height: 16),
                      _section('5. Account Security and Responsibilities', [
                        'You are solely responsible for maintaining the confidentiality of Your account credentials, all activity that occurs under Your account, and promptly notifying Us of any unauthorised use.',
                        'The Operator shall not be liable for any loss arising from unauthorised use of Your account where such use results from Your failure to safeguard Your credentials.',
                      ]),
                      _section('6. Acceptable Use Policy', [
                        'Ciphering is intended for legitimate personal privacy and communication management. You agree not to use the Service to:',
                      ]),
                      _bulletList([
                        'Commit or facilitate any form of fraud, identity theft, phishing, or financial crime.',
                        'Send or facilitate spam or telemarketing.',
                        'Harass, threaten, stalk, defame, or abuse any person.',
                        'Impersonate any individual, entity, or government official.',
                        'Circumvent OTP verification systems or authentication mechanisms.',
                        'Evade identification by law enforcement or regulatory authorities.',
                        'Facilitate any illegal activity, including money laundering, terrorist financing, drug trafficking, or trafficking in persons.',
                        'Violate any applicable law, regulation, or order of any governmental authority.',
                        'Interfere with or disrupt the Service or its infrastructure.',
                        'Market the Service as a tool for anonymity or evasion of legal accountability.',
                      ]),
                      _bodyText(
                          'The Operator reserves the right to investigate complaints and take action including warning, suspension, or permanent termination of accounts. If the Operator reasonably believes an Alias Number is being used for illegal activity, it may immediately suspend the number and disclose account information to law enforcement without prior notice.'),
                      const SizedBox(height: 16),
                      _section('7. Alias Number Ownership and Licensing', [
                        'All Alias Numbers are and shall remain the exclusive property of the Operator and its Telecom Partners. No User acquires any ownership, portability, or transferability right over any Alias Number.',
                        'The Operator may reassign, retire, or reclaim any Alias Number at any time, with reasonable prior notice where practicable.',
                        'Alias Numbers are not portable under the Mobile Number Portability (MNP) framework of India.',
                      ]),
                      _section('8. Fees, Billing, and Refunds', [
                        'Where the Service includes paid features, the applicable fees, billing cycle, and payment methods will be clearly disclosed before any purchase. All fees are quoted in Indian Rupees (INR) and are inclusive of applicable GST unless stated otherwise.',
                        'Payments are non-refundable unless required by applicable consumer protection law or at the sole discretion of the Operator.',
                        'The Operator reserves the right to modify pricing at any time. Existing subscriptions will be honoured at the rate in effect at the time of purchase for the active billing cycle.',
                      ]),
                      _section('9. Suspension, Termination, and Account Deletion', [
                        'The Operator may suspend or terminate Your account if:',
                      ]),
                      _bulletList([
                        'You breach any provision of these Terms or the Acceptable Use Policy.',
                        'A law enforcement or regulatory authority directs such action.',
                        'Continued provision poses a risk to other Users, the Operator, or the public.',
                        'You fail to complete required KYC verification.',
                        'Your account remains inactive for more than 180 days.',
                      ]),
                      _bodyText(
                          'You may terminate Your account at any time using the in-app account deletion feature. Upon termination, all associated Alias Numbers will be deactivated.'),
                      const SizedBox(height: 16),
                      _section('10. Service Availability and Disclaimers', [
                        'The Service depends on third-party telecommunications infrastructure, internet connectivity, and device compatibility. The Operator does not guarantee uninterrupted, error-free, or continuously available service.',
                        'The Service is provided on an "as is" and "as available" basis. The Operator makes no representations or warranties, express or implied, including warranties of merchantability, fitness for a particular purpose, or non-infringement.',
                      ]),
                      _section('11. Limitation of Liability', [
                        'To the fullest extent permitted by applicable Indian law, the Operator shall not be liable for any indirect, incidental, special, consequential, or punitive damages.',
                        'The Operator\u2019s total aggregate liability shall not exceed the total fees actually paid by You in the twelve (12) months preceding the event, or INR 5,000, whichever is lower.',
                      ]),
                      _section('12. Intellectual Property', [
                        'All intellectual property rights in the Service, including the Ciphering name, logo, branding, application design, source code, and documentation, are owned by Sqewes Private Limited and are protected under applicable Indian and international intellectual property laws.',
                      ]),
                      _section('13. Indemnification', [
                        'You agree to indemnify, defend, and hold harmless the Operator from and against any claims, liabilities, damages, losses, and expenses arising out of Your use or misuse of the Service, violation of these Terms, or any third-party claim arising from Your actions.',
                      ]),
                      _section('14. Modifications to the Terms', [
                        'The Operator reserves the right to amend these Terms at any time. Where a modification materially affects Your rights, the Operator will notify You at least fifteen (15) days before the change takes effect. Continued use after the effective date constitutes acceptance.',
                      ]),
                      _section('15. Governing Law and Dispute Resolution', [
                        'These Terms shall be governed by the laws of India. Disputes shall first be addressed through good-faith negotiation for thirty (30) days.',
                        'If unresolved, disputes shall be referred to arbitration under the Arbitration and Conciliation Act, 1996. The seat of arbitration shall be Bengaluru, Karnataka. The language of arbitration shall be English.',
                        'Subject to the arbitration clause, the courts of Bengaluru, Karnataka shall have exclusive jurisdiction.',
                      ]),
                      _section('16. Severability', [
                        'If any provision of these Terms is held to be invalid, illegal, or unenforceable, the remaining provisions shall continue in full force and effect.',
                      ]),
                      _section('17. Entire Agreement', [
                        'These Terms, together with the Privacy Policy and any supplementary policies, constitute the entire agreement between You and the Operator regarding the Service.',
                      ]),
                      _section('18. Waiver', [
                        'The failure of the Operator to exercise or enforce any right or provision of these Terms shall not constitute a waiver of such right or provision.',
                      ]),
                      _section('19. Contact Information', []),
                      GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sqewes Private Limited',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _contactRow(
                                Icons.email_outlined, 'ciphering.app@gmail.com'),
                            const SizedBox(height: 4),
                            _contactRow(Icons.location_on_outlined,
                                'Bengaluru, Karnataka, India'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'By using Ciphering, You confirm that You have read, understood, and agreed to these Terms and Conditions.',
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

  static Widget _definitionList(List<List<String>> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${item[0]}: ',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                  height: 1.6,
                                ),
                              ),
                              TextSpan(
                                text: item[1],
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.6,
                                ),
                              ),
                            ],
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
