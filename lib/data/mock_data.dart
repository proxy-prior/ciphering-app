import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AliasStatus { active, paused, expired, blocked }
enum CallStatus { answered, missed, blocked, outgoing }
enum AliasCategory { work, personal, freelance, marketplace, spam }

class AliasModel {
  final String label;
  final String number;
  final AliasStatus status;
  final AliasCategory category;
  final String emoji;
  final DateTime? expiryDate;
  final DateTime? createdDate;
  final String? purpose;
  final String? plan;
  final int totalCalls;
  final int totalMessages;
  final String? lastActivity;

  const AliasModel({
    required this.label,
    required this.number,
    required this.status,
    required this.category,
    required this.emoji,
    this.expiryDate,
    this.createdDate,
    this.purpose,
    this.plan,
    this.totalCalls = 0,
    this.totalMessages = 0,
    this.lastActivity,
  });

  AliasModel copyWith({
    String? label,
    String? number,
    AliasStatus? status,
    AliasCategory? category,
    String? emoji,
    DateTime? expiryDate,
    DateTime? createdDate,
    String? purpose,
    String? plan,
    int? totalCalls,
    int? totalMessages,
    String? lastActivity,
  }) {
    return AliasModel(
      label: label ?? this.label,
      number: number ?? this.number,
      status: status ?? this.status,
      category: category ?? this.category,
      emoji: emoji ?? this.emoji,
      expiryDate: expiryDate ?? this.expiryDate,
      createdDate: createdDate ?? this.createdDate,
      purpose: purpose ?? this.purpose,
      plan: plan ?? this.plan,
      totalCalls: totalCalls ?? this.totalCalls,
      totalMessages: totalMessages ?? this.totalMessages,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }
}

class CallLogModel {
  final String callerName;
  final String callerNumber;
  final String aliasNumber;
  final String aliasLabel;
  final CallStatus status;
  final DateTime timestamp;
  final String timeGroup;
  final Duration? duration;
  final bool isBlocked;
  final bool isSaved;

  const CallLogModel({
    required this.callerName,
    required this.callerNumber,
    required this.aliasNumber,
    required this.aliasLabel,
    required this.status,
    required this.timestamp,
    required this.timeGroup,
    this.duration,
    this.isBlocked = false,
    this.isSaved = false,
  });

  CallLogModel copyWith({
    String? callerName,
    String? callerNumber,
    String? aliasNumber,
    String? aliasLabel,
    CallStatus? status,
    DateTime? timestamp,
    String? timeGroup,
    Duration? duration,
    bool? isBlocked,
    bool? isSaved,
  }) {
    return CallLogModel(
      callerName: callerName ?? this.callerName,
      callerNumber: callerNumber ?? this.callerNumber,
      aliasNumber: aliasNumber ?? this.aliasNumber,
      aliasLabel: aliasLabel ?? this.aliasLabel,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      timeGroup: timeGroup ?? this.timeGroup,
      duration: duration ?? this.duration,
      isBlocked: isBlocked ?? this.isBlocked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class MessageThreadModel {
  final String id;
  final String senderName;
  final String senderNumber;
  final String aliasNumber;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final List<MessageModel> messages;

  const MessageThreadModel({
    required this.id,
    required this.senderName,
    required this.senderNumber,
    required this.aliasNumber,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.messages = const [],
  });
}

class MessageModel {
  final String text;
  final DateTime timestamp;
  final bool isIncoming;

  const MessageModel({
    required this.text,
    required this.timestamp,
    this.isIncoming = true,
  });
}

enum NotificationType { call, missedCall, alias, security, system, block }

class NotificationModel {
  final String title;
  final String description;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;

  const NotificationModel({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  NotificationModel copyWith({
    String? title,
    String? description,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}

class UserProfile {
  final String name;
  final String phone;
  final String email;
  final DateTime dateOfBirth;
  final bool isPremium;
  final int aliasCount;
  final int memberDays;
  final bool notificationsEnabled;

  const UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    this.isPremium = false,
    this.aliasCount = 0,
    this.memberDays = 0,
    this.notificationsEnabled = true,
  });

  UserProfile copyWith({
    String? name,
    String? phone,
    String? email,
    DateTime? dateOfBirth,
    bool? isPremium,
    int? aliasCount,
    int? memberDays,
    bool? notificationsEnabled,
  }) {
    return UserProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isPremium: isPremium ?? this.isPremium,
      aliasCount: aliasCount ?? this.aliasCount,
      memberDays: memberDays ?? this.memberDays,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

class MockData {
  static final userProfile = UserProfile(
    name: 'Danvish Muthu',
    phone: '+91 87783 41153',
    email: 'danvish@example.com',
    dateOfBirth: DateTime(1995, 6, 15),
    isPremium: true,
    aliasCount: 3,
    memberDays: 128,
  );

  static final aliases = <AliasModel>[
    AliasModel(
      label: 'Insurance',
      number: '+91 76890 65432',
      status: AliasStatus.active,
      category: AliasCategory.work,
      emoji: '\u{1F4BC}',
      expiryDate: DateTime(2026, 12, 12),
      createdDate: DateTime(2025, 1, 15),
      purpose: 'Insurance calls & claims',
      plan: 'Pro Monthly',
      totalCalls: 142,
      totalMessages: 38,
      lastActivity: '2h ago',
    ),
    AliasModel(
      label: 'OLX Marketplace',
      number: '+91 98765 43210',
      status: AliasStatus.paused,
      category: AliasCategory.marketplace,
      emoji: '\u{1F6D2}',
      expiryDate: DateTime(2026, 3, 1),
      createdDate: DateTime(2025, 4, 5),
      purpose: 'Buying & selling on OLX',
      plan: 'Basic Monthly',
      totalCalls: 31,
      totalMessages: 45,
      lastActivity: '3d ago',
    ),
    AliasModel(
      label: 'Spam Trap',
      number: '+91 91234 56789',
      status: AliasStatus.expired,
      category: AliasCategory.spam,
      emoji: '\u{1F6AB}',
      createdDate: DateTime(2024, 11, 1),
      purpose: 'Screen unfamiliar contacts',
      plan: 'Free Trial',
      totalCalls: 89,
      totalMessages: 3,
      lastActivity: '2w ago',
    ),
  ];

  static final callLogs = <CallLogModel>[
    CallLogModel(
      callerName: 'Insurance HDFC',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      aliasLabel: 'Work Phone',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 15, 14, 34),
      timeGroup: 'Today',
      duration: const Duration(minutes: 4, seconds: 12),
    ),
    CallLogModel(
      callerName: 'Amazon Delivery',
      callerNumber: '+91 98765 11223',
      aliasNumber: '+91 98765 43210',
      aliasLabel: 'OLX Marketplace',
      status: CallStatus.missed,
      timestamp: DateTime(2025, 6, 15, 11, 20),
      timeGroup: 'Today',
    ),
    CallLogModel(
      callerName: 'Unknown Caller',
      callerNumber: '+91 99887 76655',
      aliasNumber: '+91 91234 56789',
      aliasLabel: 'Spam Trap',
      status: CallStatus.blocked,
      timestamp: DateTime(2025, 6, 15, 9, 15),
      timeGroup: 'Today',
    ),
    CallLogModel(
      callerName: 'Flipkart Support',
      callerNumber: '+91 98765 11223',
      aliasNumber: '+91 98123 32343',
      aliasLabel: 'House Hunt',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 14, 16, 30),
      timeGroup: 'Yesterday',
      duration: const Duration(minutes: 2, seconds: 45),
    ),
    CallLogModel(
      callerName: 'Swiggy Agent',
      callerNumber: '+91 98123 55667',
      aliasNumber: '+91 98765 43210',
      aliasLabel: 'OLX Marketplace',
      status: CallStatus.outgoing,
      timestamp: DateTime(2025, 6, 14, 10, 0),
      timeGroup: 'Yesterday',
      duration: const Duration(minutes: 1, seconds: 30),
    ),
    CallLogModel(
      callerName: 'ICICI Bank',
      callerNumber: '+91 44567 89012',
      aliasNumber: '+91 76890 65432',
      aliasLabel: 'Work Phone',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 13, 16, 45),
      timeGroup: 'This Week',
      duration: const Duration(minutes: 8, seconds: 3),
    ),
  ];

  static final notifications = <NotificationModel>[
    NotificationModel(
      title: 'Incoming call answered',
      description: 'Call from Insurance HDFC on Work Phone lasted 4m 12s',
      timestamp: DateTime(2025, 6, 15, 14, 34),
      type: NotificationType.call,
    ),
    NotificationModel(
      title: 'Missed call',
      description: 'Amazon Delivery tried to reach you on OLX Marketplace',
      timestamp: DateTime(2025, 6, 15, 11, 20),
      type: NotificationType.missedCall,
    ),
    NotificationModel(
      title: 'Spam call blocked',
      description: 'Unknown Caller was blocked on Spam Trap',
      timestamp: DateTime(2025, 6, 15, 9, 15),
      type: NotificationType.block,
    ),
    NotificationModel(
      title: 'Alias expiring soon',
      description: 'Your Spam Trap alias expires in 3 days. Renew to keep your number.',
      timestamp: DateTime(2025, 6, 14, 8, 0),
      type: NotificationType.alias,
      isRead: true,
    ),
    NotificationModel(
      title: 'Security alert',
      description: 'New device login detected from Chrome on Windows',
      timestamp: DateTime(2025, 6, 13, 22, 0),
      type: NotificationType.security,
      isRead: true,
    ),
    NotificationModel(
      title: 'Welcome to Ciphering',
      description: 'Your account is set up. Create your first alias to get started.',
      timestamp: DateTime(2025, 6, 12, 10, 0),
      type: NotificationType.system,
      isRead: true,
    ),
  ];

  static final messageThreads = <MessageThreadModel>[
    MessageThreadModel(
      id: '1',
      senderName: 'HDFC Bank',
      senderNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      lastMessage: 'Your OTP for transaction is 482931. Valid for 5 mins.',
      timestamp: DateTime(2025, 6, 14, 22, 23),
      unreadCount: 2,
      messages: [
        MessageModel(text: 'Your OTP for transaction is 482931. Valid for 5 mins.', timestamp: DateTime(2025, 6, 14, 22, 23)),
        MessageModel(text: 'Your account has been credited with INR 5,000.', timestamp: DateTime(2025, 6, 14, 10, 15)),
      ],
    ),
    MessageThreadModel(
      id: '2',
      senderName: 'Amazon',
      senderNumber: '+91 98765 11223',
      aliasNumber: '+91 98123 32343',
      lastMessage: 'Your package has been delivered to your doorstep.',
      timestamp: DateTime(2025, 6, 13, 16, 40),
      messages: [
        MessageModel(text: 'Your package has been delivered to your doorstep.', timestamp: DateTime(2025, 6, 13, 16, 40)),
        MessageModel(text: 'Your order #12345 has been shipped. Track: amzn.in/track123', timestamp: DateTime(2025, 6, 12, 9, 0)),
      ],
    ),
    MessageThreadModel(
      id: '3',
      senderName: 'Swiggy',
      senderNumber: '+91 98123 55667',
      aliasNumber: '+91 98765 43210',
      lastMessage: 'Your order is out for delivery. ETA 15 mins.',
      timestamp: DateTime(2025, 6, 10, 19, 30),
      messages: [
        MessageModel(text: 'Your order is out for delivery. ETA 15 mins.', timestamp: DateTime(2025, 6, 10, 19, 30)),
      ],
    ),
  ];

  static Color categoryTint(AliasCategory category) {
    switch (category) {
      case AliasCategory.work: return AppColors.workTint;
      case AliasCategory.personal: return AppColors.personalTint;
      case AliasCategory.freelance: return AppColors.freelanceTint;
      case AliasCategory.marketplace: return AppColors.marketplaceTint;
      case AliasCategory.spam: return AppColors.spamTint;
    }
  }
}
