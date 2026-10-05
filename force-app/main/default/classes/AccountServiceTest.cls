@isTest
private class AccountServiceTest {
  @isTest
  static void createAccountSetsDefaultRating() {
    Test.startTest();
    Account created = AccountService.createAccount('Acme Corp');
    Test.stopTest();

    Account saved = [SELECT Name, Rating FROM Account WHERE Id = :created.Id];
    Assert.areEqual(
      'Acme Corp',
      saved.Name,
      'Account should keep the name it was given.'
    );
    Assert.areEqual(
      'Warm',
      saved.Rating,
      'New Accounts should default to a Warm rating.'
    );
  }

  @isTest
  static void createAccountRejectsBlankName() {
    Test.startTest();
    try {
      AccountService.createAccount('');
      Assert.fail('A blank Account name should have thrown an exception.');
    } catch (AccountService.AccountServiceException e) {
      Assert.areEqual(
        'Account name is required.',
        e.getMessage(),
        'Unexpected error message.'
      );
    }
    Test.stopTest();
  }

  @isTest
  static void getAccountsByRatingReturnsOnlyMatches() {
    insert new List<Account>{
      new Account(Name = 'Warm Prospect', Rating = 'Warm'),
      new Account(Name = 'Cold Prospect', Rating = 'Cold')
    };

    Test.startTest();
    List<Account> warmAccounts = AccountService.getAccountsByRating('Warm');
    Test.stopTest();

    Assert.areEqual(
      1,
      warmAccounts.size(),
      'Only the Warm Account should be returned.'
    );
    Assert.areEqual(
      'Warm Prospect',
      warmAccounts[0].Name,
      'Wrong Account returned for the Warm rating.'
    );
  }
}
