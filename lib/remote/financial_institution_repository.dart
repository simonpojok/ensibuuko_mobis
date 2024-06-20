import 'package:mobis/authentication/authentication_repository.dart';

import '../models/financial_institution.dart';
import '../provider/financial_institution_provider.dart';

class FinancialInstitutionRepository {
  final FinancialInstitutionProvider financialInstitutionProvider;
  final AuthenticationRepository authenticationRepository;

  const FinancialInstitutionRepository({
    required this.financialInstitutionProvider,
    required this.authenticationRepository,
  });

  Future<List<FinancialInstitution>> getSupportedFinancialInstitutions() async {
    return await financialInstitutionProvider.getFinancialInstitutions(
      authenticationRepository.getPhoneNumber(),
    );
  }
}
