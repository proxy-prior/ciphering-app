import 'package:flutter/material.dart';

enum AliasStatus { active, expired, disabled }
enum CallStatus { answered, missed, blocked, expired }

class AliasModel {
  final String label;
  final String number;
  final AliasStatus status;
  final DateTime? expiryDate;
  final int incomingCalls;
  final int incomingMins;
  final int outgoingCalls;
  final int outgoingMins;
  final int newCallers;

  const AliasModel({
    required this.label,
    required this.number,
    required this.status,
    this.expiryDate,
    this.incomingCalls = 0,
    this.incomingMins = 0,
    this.outgoingCalls = 0,
    this.outgoingMins = 0,
    this.newCallers = 0,
  });
}

class CallLogModel {
  final String callerName;
  final String callerNumber;
  final String aliasNumber;
  final CallStatus status;
  final DateTime timestamp;
  final String timeGroup;

  const CallLogModel({
    required this.callerName,
    required this.callerNumber,
    required this.aliasNumber,
    required this.status,
    required this.timestamp,
    required this.timeGroup,
  });
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

class ActivityLogEntry {
  final String description;
  final DateTime timestamp;
  final String aliasNumber;
  final IconData icon;
  final Color iconColor;

  const ActivityLogEntry({
    required this.description,
    required this.timestamp,
    required this.aliasNumber,
    required this.icon,
    required this.iconColor,
  });
}

class UserProfile {
  final String name;
  final String phone;
  final String email;
  final DateTime dateOfBirth;
  final bool isPremium;

  const UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    this.isPremium = false,
  });
}

class MockData {
  static final userProfile = UserProfile(
    name: 'Danvish Muthu',
    phone: '+91 87783 41153',
    email: 'danvish@example.com',
    dateOfBirth: DateTime(1995, 6, 15),
    isPremium: true,
  );

  static final aliases = <AliasModel>[
    AliasModel(
      label: 'Insurance number',
      number: '+91 76890 65432',
      status: AliasStatus.active,
      expiryDate: DateTime(2025, 12, 12),
      incomingCalls: 240,
      incomingMins: 1233,
      outgoingCalls: 48,
      outgoingMins: 123,
      newCallers: 65,
    ),
    AliasModel(
      label: 'E-commerce number',
      number: '+91 98123 32343',
      status: AliasStatus.expired,
      incomingCalls: 240,
      incomingMins: 1233,
      outgoingCalls: 12,
      outgoingMins: 45,
      newCallers: 30,
    ),
    AliasModel(
      label: 'Other misc. number',
      number: '+91 98123 78667',
      status: AliasStatus.disabled,
      incomingCalls: 240,
      incomingMins: 1233,
      outgoingCalls: 8,
      outgoingMins: 20,
      newCallers: 15,
    ),
    AliasModel(
      label: 'Food delivery',
      number: '+91 98765 43210',
      status: AliasStatus.active,
      expiryDate: DateTime(2026, 3, 1),
      incomingCalls: 56,
      incomingMins: 120,
      outgoingCalls: 10,
      outgoingMins: 35,
      newCallers: 22,
    ),
  ];

  static final callLogs = <CallLogModel>[
    CallLogModel(
      callerName: 'Insurance HDFC',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 14, 22, 23),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Amazon Delivery',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.missed,
      timestamp: DateTime(2025, 6, 14, 21, 15),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Unknown Caller',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.blocked,
      timestamp: DateTime(2025, 6, 14, 20, 42),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Flipkart Support',
      callerNumber: '+91 98765 11223',
      aliasNumber: '+91 98123 32343',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 13, 14, 30),
      timeGroup: 'Yesterday',
    ),
    CallLogModel(
      callerName: 'Swiggy Agent',
      callerNumber: '+91 98123 23434',
      aliasNumber: '+91 98123 32343',
      status: CallStatus.expired,
      timestamp: DateTime(2025, 6, 9, 10, 0),
      timeGroup: 'Last Week',
    ),
    CallLogModel(
      callerName: 'ICICI Bank',
      callerNumber: '+91 44567 89012',
      aliasNumber: '+91 76890 65432',
      status: CallStatus.answered,
      timestamp: DateTime(2025, 6, 8, 16, 45),
      timeGroup: 'Last Week',
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

  static final activityLog = <ActivityLogEntry>[
    ActivityLogEntry(description: 'Alias "Food delivery" created', timestamp: DateTime(2025, 6, 14, 10, 0), aliasNumber: '+91 98765 43210', icon: Icons.add_circle_outline, iconColor: const Color(0xFF14B8A6)),
    ActivityLogEntry(description: 'Call received from Insurance HDFC', timestamp: DateTime(2025, 6, 14, 22, 23), aliasNumber: '+91 76890 65432', icon: Icons.call_received, iconColor: const Color(0xFF14B8A6)),
    ActivityLogEntry(description: 'SMS received from HDFC Bank', timestamp: DateTime(2025, 6, 14, 22, 23), aliasNumber: '+91 76890 65432', icon: Icons.message_outlined, iconColor: const Color(0xFF5B8DEF)),
    ActivityLogEntry(description: 'Spam call blocked from Unknown Caller', timestamp: DateTime(2025, 6, 14, 20, 42), aliasNumber: '+91 76890 65432', icon: Icons.block, iconColor: const Color(0xFFA78BFA)),
    ActivityLogEntry(description: 'Alias "E-commerce number" expired', timestamp: DateTime(2025, 6, 12, 0, 0), aliasNumber: '+91 98123 32343', icon: Icons.timer_off_outlined, iconColor: const Color(0xFFF87171)),
    ActivityLogEntry(description: 'Missed call from Amazon Delivery', timestamp: DateTime(2025, 6, 14, 21, 15), aliasNumber: '+91 76890 65432', icon: Icons.call_missed, iconColor: const Color(0xFFFB7185)),
    ActivityLogEntry(description: 'Alias "Other misc. number" disabled', timestamp: DateTime(2025, 6, 10, 12, 0), aliasNumber: '+91 98123 78667', icon: Icons.pause_circle_outline, iconColor: const Color(0xFFFB923C)),
    ActivityLogEntry(description: 'Call received from ICICI Bank', timestamp: DateTime(2025, 6, 8, 16, 45), aliasNumber: '+91 76890 65432', icon: Icons.call_received, iconColor: const Color(0xFF14B8A6)),
  ];
}
