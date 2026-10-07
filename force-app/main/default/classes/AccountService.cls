public with sharing class AccountService {
  public static final String DEFAULT_RATING = 'Hot';

  public class AccountServiceException extends Exception {
  }

  // Creates an Account with the team's default rating.
  public static Account createAccount(String name) {
    if (String.isBlank(name)) {
      throw new AccountServiceException('Account name is required.');
    }
    Account account = new Account(Name = name, Rating = DEFAULT_RATING);
    insert as user account;
    return account;
  }

  // Returns Accounts matching a rating, ordered by name.
  public static List<Account> getAccountsByRating(String rating) {
    return [
      SELECT Id, Name, Rating
      FROM Account
      WHERE Rating = :rating
      WITH USER_MODE
      ORDER BY Name
    ];
  }
}
