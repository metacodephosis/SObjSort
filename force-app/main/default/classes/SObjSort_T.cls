@IsTest
private class SObjSort_T {
    /**
     * specialized sort methods
     */

    @IsTest
    static void takeFirst() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = 'C'), new Account(Name = 'D'), new Account(Name = 'B')
        };

        Account sortedAccount = (Account) SObjSort.ascending(Account.Name).sortTakeFirst(accounts);
        System.assertEquals('A', sortedAccount.Name);
    }

    @IsTest
    static void takeLast() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = 'C'), new Account(Name = 'D'), new Account(Name = 'B')
        };

        Account sortedAccount = (Account) SObjSort.ascending(Account.Name).sortTakeLast(accounts);
        System.assertEquals('D', sortedAccount.Name);
    }

    @IsTest
    static void takeN() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = 'C'), new Account(Name = 'D'), new Account(Name = 'B')
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.ascending(Account.Name).sortTakeN(accounts, 2);
        System.assertEquals('A', sortedAccounts[0].Name);
        System.assertEquals('B', sortedAccounts[1].Name);
    }

    @IsTest
    static void takeN_lessEquals0() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = 'C'), new Account(Name = 'D'), new Account(Name = 'B')
        };

        try {
            SObjSort.ascending(Account.Name).sortTakeN(accounts, 0);
            System.assert(false, 'should throw exception');
        } 
        catch(Exception e) { }
    }    

    /**
     * String
     */

    @IsTest
    static void asc_String() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = 'C'), new Account(Name = 'D'), new Account(Name = 'B')
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.ascending(Account.Name).sort(accounts);

        System.assertEquals('A', sortedAccounts[0].Name);
        System.assertEquals('B', sortedAccounts[1].Name);
        System.assertEquals('C', sortedAccounts[2].Name);
        System.assertEquals('D', sortedAccounts[3].Name);
    }

    @IsTest
    static void desc_String() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = 'C'), new Account(Name = 'D'), new Account(Name = 'B')
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.descending(Account.Name).sort(accounts);

        System.assertEquals('D', sortedAccounts[0].Name);
        System.assertEquals('C', sortedAccounts[1].Name);
        System.assertEquals('B', sortedAccounts[2].Name);
        System.assertEquals('A', sortedAccounts[3].Name);
    }

    @IsTest
    static void desc_String_null() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = null), new Account(Name = 'D'), new Account(Name = 'B')
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.descending(Account.Name).sort(accounts);

        System.assertEquals('D', sortedAccounts[0].Name);
        System.assertEquals('B', sortedAccounts[1].Name);
        System.assertEquals('A', sortedAccounts[2].Name);
        System.assertEquals(null, sortedAccounts[3].Name);
    }

    @IsTest
    static void asc_String_null() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A'), new Account(Name = null), new Account(Name = 'D'), new Account(Name = 'B')
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.ascending(Account.Name).sort(accounts);

        System.assertEquals('A', sortedAccounts[0].Name);
        System.assertEquals('B', sortedAccounts[1].Name);
        System.assertEquals('D', sortedAccounts[2].Name);
        System.assertEquals(null, sortedAccounts[3].Name);
    }

    /**
     * Decimal
     */

    @IsTest
    static void asc_Decimal() {
        List<Account> accounts = new List<Account> {
            new Account(AnnualRevenue = 1), new Account(AnnualRevenue = 3), 
            new Account(AnnualRevenue = 4), new Account(AnnualRevenue = 2)
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.ascending(Account.AnnualRevenue).sort(accounts);

        System.assertEquals(1, sortedAccounts[0].AnnualRevenue);
        System.assertEquals(2, sortedAccounts[1].AnnualRevenue);
        System.assertEquals(3, sortedAccounts[2].AnnualRevenue);
        System.assertEquals(4, sortedAccounts[3].AnnualRevenue);
    }

    @IsTest
    static void desc_Decimal() {
        List<Account> accounts = new List<Account> {
            new Account(AnnualRevenue = 1), new Account(AnnualRevenue = 3), 
            new Account(AnnualRevenue = 4), new Account(AnnualRevenue = 2)
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.descending(Account.AnnualRevenue).sort(accounts);

        System.assertEquals(4, sortedAccounts[0].AnnualRevenue);
        System.assertEquals(3, sortedAccounts[1].AnnualRevenue);
        System.assertEquals(2, sortedAccounts[2].AnnualRevenue);
        System.assertEquals(1, sortedAccounts[3].AnnualRevenue);
    }

    @IsTest
    static void desc_Decimal_null() {
        List<Account> accounts = new List<Account> {
            new Account(AnnualRevenue = 1), new Account(AnnualRevenue = null), 
            new Account(AnnualRevenue = 4), new Account(AnnualRevenue = 2)
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.descending(Account.AnnualRevenue).sort(accounts);

        System.assertEquals(4, sortedAccounts[0].AnnualRevenue);
        System.assertEquals(2, sortedAccounts[1].AnnualRevenue);
        System.assertEquals(1, sortedAccounts[2].AnnualRevenue);
        System.assertEquals(null, sortedAccounts[3].AnnualRevenue);
    }

    @IsTest
    static void asc_Decimal_null() {
        List<Account> accounts = new List<Account> {
            new Account(AnnualRevenue = 1), new Account(AnnualRevenue = null), 
            new Account(AnnualRevenue = 4), new Account(AnnualRevenue = 2)
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.ascending(Account.AnnualRevenue).sort(accounts);

        System.assertEquals(1, sortedAccounts[0].AnnualRevenue);
        System.assertEquals(2, sortedAccounts[1].AnnualRevenue);
        System.assertEquals(4, sortedAccounts[2].AnnualRevenue);
        System.assertEquals(null, sortedAccounts[3].AnnualRevenue);
    }

    /**
     * Datetime
     */

    @IsTest
    static void asc_Datetime() {
        Date bday1 = System.today();
        Date bday2 = System.today().addDays(1);
        Date bday3 = System.today().addDays(2);
        Date bday4 = System.today().addDays(3);

        List<Contact> contacts = new List<Contact> {
            new Contact(Birthdate = bday1), new Contact(Birthdate = bday3), 
            new Contact(Birthdate = bday4), new Contact(Birthdate = bday2)
        };

        List<Contact> sortedContacts = (List<Contact>) SObjSort.ascending(Contact.Birthdate).sort(contacts);

        System.assertEquals(bday1, sortedContacts[0].Birthdate);
        System.assertEquals(bday2, sortedContacts[1].Birthdate);
        System.assertEquals(bday3, sortedContacts[2].Birthdate);
        System.assertEquals(bday4, sortedContacts[3].Birthdate);
    }

    @IsTest
    static void desc_Datetime() {
        Date bday1 = System.today();
        Date bday2 = System.today().addDays(1);
        Date bday3 = System.today().addDays(2);
        Date bday4 = System.today().addDays(3);

        List<Contact> contacts = new List<Contact> {
            new Contact(Birthdate = bday1), new Contact(Birthdate = bday3), 
            new Contact(Birthdate = bday4), new Contact(Birthdate = bday2)
        };

        List<Contact> sortedContacts = (List<Contact>) SObjSort.descending(Contact.Birthdate).sort(contacts);

        System.assertEquals(bday4, sortedContacts[0].Birthdate);
        System.assertEquals(bday3, sortedContacts[1].Birthdate);
        System.assertEquals(bday2, sortedContacts[2].Birthdate);
        System.assertEquals(bday1, sortedContacts[3].Birthdate);
    }

    @IsTest
    static void desc_Datetime_null() {
        Date bday1 = System.today();
        Date bday2 = System.today().addDays(1);
        Date bday3 = null;
        Date bday4 = System.today().addDays(3);

        List<Contact> contacts = new List<Contact> {
            new Contact(Birthdate = bday1), new Contact(Birthdate = bday3), 
            new Contact(Birthdate = bday4), new Contact(Birthdate = bday2)
        };

        List<Contact> sortedContacts = (List<Contact>) SObjSort.descending(Contact.Birthdate).sort(contacts);

        System.assertEquals(bday4, sortedContacts[0].Birthdate);
        System.assertEquals(bday2, sortedContacts[1].Birthdate);
        System.assertEquals(bday1, sortedContacts[2].Birthdate);
        System.assertEquals(bday3, sortedContacts[3].Birthdate);
    }

    @IsTest
    static void asc_Datetime_null() {
        Date bday1 = System.today();
        Date bday2 = System.today().addDays(1);
        Date bday3 = null;
        Date bday4 = System.today().addDays(3);

        List<Contact> contacts = new List<Contact> {
            new Contact(Birthdate = bday1), new Contact(Birthdate = bday3), 
            new Contact(Birthdate = bday4), new Contact(Birthdate = bday2)
        };

        List<Contact> sortedContacts = (List<Contact>) SObjSort.ascending(Contact.Birthdate).sort(contacts);

        System.assertEquals(bday1, sortedContacts[0].Birthdate);
        System.assertEquals(bday2, sortedContacts[1].Birthdate);
        System.assertEquals(bday4, sortedContacts[2].Birthdate);
        System.assertEquals(bday3, sortedContacts[3].Birthdate);
    }

    /**
     * Time
     */

    @IsTest
    static void asc_Time() {
        Time t1 = Time.newInstance(1, 1, 1, 1);
        Time t2 = Time.newInstance(2, 2, 2, 2);
        Time t3 = Time.newInstance(3, 3, 3, 3);
        Time t4 = Time.newInstance(4, 4, 4, 4);

        List<BusinessHours> bhs = new List<BusinessHours> {
            new BusinessHours(SundayStartTime = t1),
            new BusinessHours(SundayStartTime = t2),
            new BusinessHours(SundayStartTime = t3),
            new BusinessHours(SundayStartTime = t4)
        };

        List<BusinessHours> sortedBhs = (List<BusinessHours>) SObjSort.ascending(BusinessHours.SundayStartTime).sort(bhs);

        System.assertEquals(t1, sortedBhs[0].SundayStartTime);
        System.assertEquals(t2, sortedBhs[1].SundayStartTime);
        System.assertEquals(t3, sortedBhs[2].SundayStartTime);
        System.assertEquals(t4, sortedBhs[3].SundayStartTime);
    }

    @IsTest
    static void desc_Time() {
        Time t1 = Time.newInstance(1, 1, 1, 1);
        Time t2 = Time.newInstance(2, 2, 2, 2);
        Time t3 = Time.newInstance(3, 3, 3, 3);
        Time t4 = Time.newInstance(4, 4, 4, 4);

        List<BusinessHours> bhs = new List<BusinessHours> {
            new BusinessHours(SundayStartTime = t1),
            new BusinessHours(SundayStartTime = t2),
            new BusinessHours(SundayStartTime = t3),
            new BusinessHours(SundayStartTime = t4)
        };

        List<BusinessHours> sortedBhs = (List<BusinessHours>) SObjSort.descending(BusinessHours.SundayStartTime).sort(bhs);

        System.assertEquals(t4, sortedBhs[0].SundayStartTime);
        System.assertEquals(t3, sortedBhs[1].SundayStartTime);
        System.assertEquals(t2, sortedBhs[2].SundayStartTime);
        System.assertEquals(t1, sortedBhs[3].SundayStartTime);
    }

    @IsTest
    static void asc_Time_null() {
        Time t1 = Time.newInstance(1, 1, 1, 1);
        Time t2 = Time.newInstance(2, 2, 2, 2);
        Time t3 = null;
        Time t4 = Time.newInstance(4, 4, 4, 4);

        List<BusinessHours> bhs = new List<BusinessHours> {
            new BusinessHours(SundayStartTime = t1),
            new BusinessHours(SundayStartTime = t2),
            new BusinessHours(SundayStartTime = t3),
            new BusinessHours(SundayStartTime = t4)
        };

        List<BusinessHours> sortedBhs = (List<BusinessHours>) SObjSort.ascending(BusinessHours.SundayStartTime).sort(bhs);

        System.assertEquals(t1, sortedBhs[0].SundayStartTime);
        System.assertEquals(t2, sortedBhs[1].SundayStartTime);
        System.assertEquals(t4, sortedBhs[2].SundayStartTime);
        System.assertEquals(t3, sortedBhs[3].SundayStartTime);
    }

    @IsTest
    static void desc_Time_null() {
        Time t1 = Time.newInstance(1, 1, 1, 1);
        Time t2 = Time.newInstance(2, 2, 2, 2);
        Time t3 = null;
        Time t4 = Time.newInstance(4, 4, 4, 4);

        List<BusinessHours> bhs = new List<BusinessHours> {
            new BusinessHours(SundayStartTime = t1),
            new BusinessHours(SundayStartTime = t2),
            new BusinessHours(SundayStartTime = t3),
            new BusinessHours(SundayStartTime = t4)
        };

        List<BusinessHours> sortedBhs = (List<BusinessHours>) SObjSort.descending(BusinessHours.SundayStartTime).sort(bhs);

        System.assertEquals(t4, sortedBhs[0].SundayStartTime);
        System.assertEquals(t2, sortedBhs[1].SundayStartTime);
        System.assertEquals(t1, sortedBhs[2].SundayStartTime);
        System.assertEquals(null, sortedBhs[3].SundayStartTime);
    }

    /**
     * sort on multiple fields
     */

    @IsTest
    static void sortOnMultipleFields_ascThenDesc() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A', AnnualRevenue = 4), 
            new Account(Name = 'C', AnnualRevenue = 3), 
            new Account(Name = 'B', AnnualRevenue = 1), 
            new Account(Name = 'A', AnnualRevenue = 2)
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.ascending(Account.AnnualRevenue)
                                                            .descending(Account.Name)
                                                            .sort(accounts);

        System.assertEquals('C', sortedAccounts[0].Name);
        System.assertEquals('B', sortedAccounts[1].Name);
        System.assertEquals(2, sortedAccounts[2].AnnualRevenue);
        System.assertEquals(4, sortedAccounts[3].AnnualRevenue);
    }

    @IsTest
    static void sortOnMultipleFields_descThenAsc() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'A', AnnualRevenue = 4), 
            new Account(Name = 'C', AnnualRevenue = 3), 
            new Account(Name = 'B', AnnualRevenue = 1), 
            new Account(Name = 'A', AnnualRevenue = 2)
        };

        List<Account> sortedAccounts = (List<Account>) SObjSort.descending(Account.AnnualRevenue)
                                                            .ascending(Account.Name)
                                                            .sort(accounts);

        System.assertEquals(4, sortedAccounts[0].AnnualRevenue);
        System.assertEquals(2, sortedAccounts[1].AnnualRevenue);
        System.assertEquals('B', sortedAccounts[2].Name);
        System.assertEquals('C', sortedAccounts[3].Name);
    }

    @IsTest
    static void fieldNull() {
        try {
            SObjSort.ascending(null);
            System.assert(false, 'should throw exception');
        }
        catch(Exception e) { }
    }

    @IsTest
    static void sObjsNull() {
        System.assertEquals(null, SObjSort.ascending(Account.Name).sortTakeFirst(null));
        System.assertEquals(null, SObjSort.ascending(Account.Name).sortTakeLast(null));
        System.assertEquals(new List<SObject>(), SObjSort.ascending(Account.Name).sortTakeN(null, 2));
        System.assertEquals(new List<SObject>(), SObjSort.ascending(Account.Name).sort(null));
    }
    
    @IsTest
    static void sortByParentField_ascending() {
        Account acc_A = new Account(Name = 'A');
        Account acc_B = new Account(Name = 'B');
        Account acc_C = new Account(Name = 'C');
        Contact contact_A = new Contact(LastName = 'A');
        Contact contact_B = new Contact(LastName = 'B');
        Contact contact_C = new Contact(LastName = 'C');
        contact_A = (Contact) putValue(contact_A, Contact.AccountId, acc_A);
        contact_B = (Contact) putValue(contact_B, Contact.AccountId, acc_B);
        contact_C = (Contact) putValue(contact_C, Contact.AccountId, acc_C);
        List<Contact> contacts = new List<Contact>{ contact_C, contact_B, contact_A };

        List<Contact> sortedContacts = (List<Contact>) SObjSort.ascending(Contact.AccountId, Account.Name).sort(contacts);

        System.assertEquals('A', sortedContacts[0].LastName);
        System.assertEquals('B', sortedContacts[1].LastName);
        System.assertEquals('C', sortedContacts[2].LastName);
    }

    @IsTest
    static void sortByParentField_descending() {
        Account acc_A = new Account(Name = 'A');
        Account acc_B = new Account(Name = 'B');
        Account acc_C = new Account(Name = 'C');
        Contact contact_A = new Contact(LastName = 'A');
        Contact contact_B = new Contact(LastName = 'B');
        Contact contact_C = new Contact(LastName = 'C');
        contact_A = (Contact) putValue(contact_A, Contact.AccountId, acc_A);
        contact_B = (Contact) putValue(contact_B, Contact.AccountId, acc_B);
        contact_C = (Contact) putValue(contact_C, Contact.AccountId, acc_C);
        List<Contact> contacts = new List<Contact>{ contact_C, contact_B, contact_A };

        List<Contact> sortedContacts = (List<Contact>) SObjSort.descending(Contact.AccountId, Account.Name).sort(contacts);

        System.assertEquals('C', sortedContacts[0].LastName);
        System.assertEquals('B', sortedContacts[1].LastName);
        System.assertEquals('A', sortedContacts[2].LastName);
    }

    static SObject putValue(SObject sObj, SObjectField relationshipField, Object value) {
		Map<String,Object> sObjMap = (Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(sObj));
		sObjMap.put(relationshipField.getDescribe().getRelationshipName(), value);		
        return (SObject) JSON.deserialize(JSON.serialize(sObjMap), SObject.class);
    }
}