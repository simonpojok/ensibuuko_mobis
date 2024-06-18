import '../models/financial_institution.dart';

class FinancialInstitutionRepository {
  Future<List<FinancialInstitution>> getSupportedFinancialInstitutions() async {
    return [
      const FinancialInstitution(
        name: 'Rukiga SACCO',
        slogan: 'Save for a better future',
      ),
      const FinancialInstitution(
        name: 'KINA SACCO',
        slogan: "Kulw'okweterekera n'okwewola",
      ),
      const FinancialInstitution(
        name: 'Deed Microfinance',
        slogan: 'We care about your growth',
      ),
    ];
  }
}
