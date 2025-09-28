import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'blocs/cart/cart_bloc.dart';
import 'blocs/order/order_bloc.dart';
import 'blocs/restaurant/restaurant_bloc.dart';
import 'repositories/order_repository_impl.dart';
import 'repositories/restaurant_repository_impl.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantBloc(
            restaurantRepository: RestaurantRepositoryImpl(
              client: http.Client(),
            ),
          ),
        ),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(
          create: (context) =>
              OrderBloc(orderRepository: OrderRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        title: 'Food Delivery',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF27F0D), 
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF8F7F5), 
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
            ThemeData.light().textTheme.copyWith(
              displayLarge: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              displayMedium: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              displaySmall: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              headlineLarge: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              headlineMedium: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              headlineSmall: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              titleLarge: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181411),
              ),
              titleMedium: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181411),
              ),
              titleSmall: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181411),
              ),
              bodyLarge: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF181411),
              ),
              bodyMedium: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF181411),
              ),
              bodySmall: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF8A7560),
              ),
              labelLarge: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF181411),
              ),
              labelMedium: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF181411),
              ),
              labelSmall: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8A7560),
              ),
            ),
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color(0xFFF27F0D),
            foregroundColor: Colors.white,
            titleTextStyle: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF27F0D), 
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              textStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
