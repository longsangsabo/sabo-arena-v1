import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase Configuration
class SupabaseConfig {
  static const String supabaseUrl = 'https://mkuwhcpqwpmwueoclwga.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1rdXdoY3Bxd3Btd3Vlb2Nsd2dhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTczOTUyMDUsImV4cCI6MjA3Mjk3MTIwNX0.FZ8JuUZYPGwf5hFmEbTbTY_dlFaJ_7lkJJV8iSDFctA';
  
  // Service role key (for admin operations - không expose trong client)
  static const String supabaseServiceRoleKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1rdXdoY3Bxd3Btd3Vlb2Nsd2dhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NzM5NTIwNSwiZXhwIjoyMDcyOTcxMjA1fQ.r8BK8zn5rM22DHtVESeu1sUwb9YgD9ARWBUfCDKVjic';

  /// Initialize Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true, // Enable debug mode for development
    );
  }

  /// Get Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;

  /// Get current user
  static User? get currentUser => client.auth.currentUser;

  /// Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;
}

/// Global Supabase client getter
SupabaseClient get supabase => SupabaseConfig.client;
