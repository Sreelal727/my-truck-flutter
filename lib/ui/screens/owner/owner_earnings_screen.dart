import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../widgets/widgets.dart';

class _Transaction {
  final String orderId;
  final int amount;
  final bool isCredit;
  final String date;
  final String description;

  const _Transaction({
    required this.orderId,
    required this.amount,
    required this.isCredit,
    required this.date,
    required this.description,
  });
}

const _mockTransactions = [
  _Transaction(
    orderId: 'ORD-1020',
    amount: 28000,
    isCredit: true,
    date: '8 Feb 2025',
    description: 'Payment received',
  ),
  _Transaction(
    orderId: 'ORD-1020',
    amount: 2800,
    isCredit: false,
    date: '8 Feb 2025',
    description: 'Commission (10%)',
  ),
  _Transaction(
    orderId: 'ORD-1015',
    amount: 18500,
    isCredit: true,
    date: '5 Feb 2025',
    description: 'Payment received',
  ),
  _Transaction(
    orderId: 'ORD-1015',
    amount: 1850,
    isCredit: false,
    date: '5 Feb 2025',
    description: 'Commission (10%)',
  ),
  _Transaction(
    orderId: 'ORD-1008',
    amount: 35000,
    isCredit: true,
    date: '1 Feb 2025',
    description: 'Payment received',
  ),
];

// Monthly earnings data (last 6 months)
final _monthlyEarnings = [
  ('Sep', 85000.0),
  ('Oct', 112000.0),
  ('Nov', 98000.0),
  ('Dec', 134000.0),
  ('Jan', 145000.0),
  ('Feb', 81500.0),
];

class OwnerEarningsScreen extends ConsumerWidget {
  const OwnerEarningsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MtSpacing.xl,
                  MtSpacing.lg,
                  MtSpacing.xl,
                  MtSpacing.md,
                ),
                child: Text('Earnings', style: MtTypography.h2),
              ),

              // Wallet card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(MtSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        MtColors.primary,
                        Color(0xFF0052CC),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(MtBorderRadius.xl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: MtTypography.bodySmall.copyWith(
                          color: MtColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: MtSpacing.sm),
                      Text(
                        '\u20B91,24,500',
                        style: MtTypography.h1.copyWith(
                          color: MtColors.white,
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: MtSpacing.xl),
                      SizedBox(
                        width: 130,
                        child: MtButton(
                          title: 'Withdraw',
                          size: MtButtonSize.sm,
                          variant: MtButtonVariant.outline,
                          fullWidth: true,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Withdrawal feature coming soon',
                                ),
                                backgroundColor: MtColors.surfaceElevated,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    MtBorderRadius.sm,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: MtSpacing.xxl),

              // Monthly Earnings Chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: MtCard(
                  variant: MtCardVariant.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Earnings',
                        style: MtTypography.label,
                      ),
                      const SizedBox(height: MtSpacing.xl),
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 160000,
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (_) => MtColors.surfaceElevated,
                                tooltipPadding: const EdgeInsets.symmetric(
                                  horizontal: MtSpacing.md,
                                  vertical: MtSpacing.sm,
                                ),
                                tooltipRoundedRadius: MtBorderRadius.sm,
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  final month = _monthlyEarnings[group.x.toInt()].$1;
                                  final value = rod.toY.toInt();
                                  return BarTooltipItem(
                                    '$month\n\u20B9${_formatAmount(value)}',
                                    MtTypography.caption.copyWith(
                                      color: MtColors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index < 0 ||
                                        index >= _monthlyEarnings.length) {
                                      return const SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        _monthlyEarnings[index].$1,
                                        style: MtTypography.caption.copyWith(
                                          color: MtColors.textTertiary,
                                          fontSize: 11,
                                        ),
                                      ),
                                    );
                                  },
                                  reservedSize: 28,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 48,
                                  interval: 40000,
                                  getTitlesWidget: (value, meta) {
                                    if (value == 0) {
                                      return const SizedBox.shrink();
                                    }
                                    final label = '\u20B9${(value / 1000).toInt()}K';
                                    return Text(
                                      label,
                                      style: MtTypography.caption.copyWith(
                                        color: MtColors.textTertiary,
                                        fontSize: 10,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 40000,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: MtColors.border,
                                  strokeWidth: 0.5,
                                );
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(
                              _monthlyEarnings.length,
                              (i) => BarChartGroupData(
                                x: i,
                                barRods: [
                                  BarChartRodData(
                                    toY: _monthlyEarnings[i].$2,
                                    color: MtColors.primary,
                                    width: 24,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: MtSpacing.xl),

              // This Month Summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: MtCard(
                  variant: MtCardVariant.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This Month',
                        style: MtTypography.label,
                      ),
                      const SizedBox(height: MtSpacing.lg),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryItem(
                              label: 'Total Earnings',
                              value: '\u20B981,500',
                              valueColor: MtColors.green,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 44,
                            color: MtColors.border,
                          ),
                          Expanded(
                            child: _SummaryItem(
                              label: 'Commission',
                              value: '\u20B98,150',
                              valueColor: MtColors.red,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 44,
                            color: MtColors.border,
                          ),
                          Expanded(
                            child: _SummaryItem(
                              label: 'Trips',
                              value: '12',
                              valueColor: MtColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: MtSpacing.xl),

              // Recent Transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                child: Text(
                  'Recent Transactions',
                  style: MtTypography.label,
                ),
              ),
              const SizedBox(height: MtSpacing.md),
              ...List.generate(_mockTransactions.length, (index) {
                final txn = _mockTransactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MtSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      _TransactionRow(transaction: txn),
                      if (index < _mockTransactions.length - 1)
                        Divider(
                          color: MtColors.border,
                          height: 1,
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MtSpacing.sm),
      child: Column(
        children: [
          Text(
            value,
            style: MtTypography.h4.copyWith(color: valueColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: MtTypography.caption.copyWith(
              color: MtColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final _Transaction transaction;
  const _TransactionRow({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MtSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: transaction.isCredit
                  ? MtColors.green.withValues(alpha: 0.15)
                  : MtColors.red.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              transaction.isCredit
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              size: 18,
              color: transaction.isCredit ? MtColors.green : MtColors.red,
            ),
          ),
          const SizedBox(width: MtSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: MtTypography.bodySmall,
                ),
                const SizedBox(height: 2),
                Text(
                  '${transaction.orderId}  |  ${transaction.date}',
                  style: MtTypography.caption.copyWith(
                    color: MtColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.isCredit ? '+' : '-'}\u20B9${_formatAmount(transaction.amount)}',
            style: MtTypography.label.copyWith(
              color: transaction.isCredit ? MtColors.green : MtColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatAmount(int amount) {
  final str = amount.toString();
  if (str.length <= 3) return str;
  final lastThree = str.substring(str.length - 3);
  final remaining = str.substring(0, str.length - 3);
  final formatted = remaining.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{2})+$)'),
    (m) => '${m[1]},',
  );
  return '$formatted,$lastThree';
}
