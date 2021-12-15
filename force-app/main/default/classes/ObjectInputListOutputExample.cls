public with sharing class ObjectInputListOutputExample {
    public static List<Contact> getAccountContacts(Account acct) {
        List<Contact> contacts = [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            WHERE AccountId = :acct.Id
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];

        return contacts;
    }
}
