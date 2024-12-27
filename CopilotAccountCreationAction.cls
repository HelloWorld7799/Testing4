public with sharing class CopilotAccountCreationAction {
    
    // Define a data structure for inputs to the invocable method
    public class AccountInput {
        @InvocableVariable(label='Account Name' required=true)
        public String accountName;
        
        @InvocableVariable(label='Account Phone')
        public String phone;
        
        @InvocableVariable(label='Account Website')
        public String website;
        
        @InvocableVariable(label='Account Description')
        public String description;
    }
    
    // Define a data structure for outputs from the invocable method
    public class AccountOutput {
        @InvocableVariable(label='Account ID')
        public Id accountId;
        
        @InvocableVariable(label='Success Message')
        public String message;
    }
    
    // Invocable method to create the account
    @InvocableMethod(label='Create Account' description='Creates an Account with the provided details.')
    public static List<AccountOutput> createAccount(List<AccountInput> inputs) {
        List<AccountOutput> results = new List<AccountOutput>();
        
        for (AccountInput input : inputs) {
            Account newAccount = new Account(
                Name = input.accountName,
                Phone = input.phone,
                Website = input.website,
                Description = input.description
            );
            insert newAccount;
            
            // Prepare the output with the newly created Account ID and a success message
            AccountOutput output = new AccountOutput();
            output.accountId = newAccount.Id;
            output.message = 'Account created successfully with ID: ' + newAccount.Id;
            results.add(output);
        }
        
        return results;
    }
}