/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Your Name
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> GetAllLeads () {
        Lead[] myLead = [SELECT Id,LastName,Company,Phone,Email FROM Lead];
        return myLead;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> GetContactsByFirstName (String name) {
        Contact[] myContacts = [SELECT Name,Id from Contact WHERE FirstName = :name];
        if (myContacts.size()>0) {
            return myContacts;    
        }
        else {
            return null;
        }
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> GetContactIdsByLastName () {
        Contact[] myContacts = [SELECT Name,Id from Contact WHERE LastName IN ('Smith','Jones')];
        List<Id> conIds = new List<Id>();
        if (myContacts.size()>0) {
            for (Contact con : myContacts) {
                conIds.add(con.Id);
            }
            return conIds;    
        }
        else {
            return null;
        }
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> GetClosedWonOpportunityCountByAccount (Id accountId) {
        Opportunity[] myOpps = [SELECT Name,
                                       StageName,
                                       CloseDate,
                                       AccountId,
                                       Amount 
                                FROM   Opportunity 
                                WHERE accountId = :accountId AND StageName = 'Closed Won'];
        if (myOpps.size()>0) {
            return myOpps;
        }
        else {
            return null;
        }
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer GetAccountCount () {
        Account[] myAccounts = [SELECT Id FROM Account];
        if (myAccounts.size()>0) {
            return myAccounts.size();
        }
        else {
            return 0;
        }
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> GetTasksDueNextWeek () {
        Task[] Tasklist = [SELECT Id,Subject FROM Task WHERE ActivityDate <= :Date.today().addDays(7)];
        Map<Id, Task> myTaskMap = new Map<Id, Task>();
        if (Tasklist.size()>0) {
            for (Task myT : Tasklist) {
                myTaskMap.put(myT.Id, myT);
            }
            return myTaskMap;
        }
        else {
            return null;
        }
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> GetContactsByEmailDomain () {
        Contact[] myContacts = [SELECT Id,Name,EMAIL FROM Contact WHERE EMAIL LIKE :'%example.com'];
        if (myContacts.size()>0) {
            return myContacts;
        }
        else {
            return null;
        }
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String updatedKeyword = '%' + keyword + '%';
        Opportunity[] myOpps = [SELECT Name,
                                       StageName,
                                       CloseDate,
                                       AccountId,
                                       Amount 
                                FROM   Opportunity 
                                WHERE NAME LIKE :updatedKeyword];
        if (myOpps.size()>0) {
            return myOpps;
        }
        else {
            List<Opportunity> myOpps1 = new List<Opportunity>();
            return myOpps1;  
        } 
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        Case[] cases = [SELECT ID,Origin FROM CASE WHERE ORIGIN NOT IN ('Web','Email','')];
        if (cases.size()>0) {
            return cases;
        } else {
            return null;
        }     
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
   public static List<Lead> GetLeadsBySourceOrTitle (String source, String keyword) {
    source = '%'+ source +'%';
    keyword = '%'+ keyword +'%';

    Lead[] myLead = [SELECT Id,LastName,Company,Phone,Email,LeadSource,Title FROM Lead WHERE (LeadSource LIKE :source) OR (Title LIKE :keyword)];
        if (myLead.size()>0) {
            return myLead;
        } else {
            return null;
        }
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        Contact[] myContacts = [SELECT Name from Contact where AccountId = :accountId];
        List<String> myList= new List<String>();
        if (myCOntacts.size()>0) {
            for (Contact con : myContacts) {
                myList.add(con.Name);
            }
        }
            return myList;
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        List <AggregateResult> totalRevenue = [SELECT SUM(Amount) totalRev from Opportunity where StageName = :stage];
        Decimal total;
        if (totalRevenue.size()>0) {
           for (AggregateResult ar : totalRevenue) {
           total = (Decimal) ar.get('totalRev');
            }         
        } 
        return total;
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        Account[] myList = [Select Name,Id FROM Account Order by Name LIMIT 10];
        return myList;
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        Opportunity[] myOptList = [Select Id,Name,CloseDate,Amount from Opportunity where Amount>100000 order by CloseDate LIMIT 5];
        return myOptList; 
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        Contact[] myCons = [SELECT Id,Name,BirthDate FROM Contact Order by Birthdate desc LIMIT 3];
        return myCons; // Replace null with the variable you used to store the result
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        Case[] myCases = [SELECT Id,CreatedDate,Status FROM Case WHERE Status = 'Open' Order by CreatedDate LIMIT 10 OFFSET 5 ];
        return myCases; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Case[] myCaseIds = [SELECT Id FROM Case WHERE AccountId = :accountId];
        Set<Id> CaseIds = new Set<Id>();
        for (Case cs : myCaseIds) {
            CaseIds.add(cs.Id);
        }
        return CaseIds;
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        Account[] myAcc = [select Id,Name from Account where BillingCountry NOT IN (:country)];
        for (Account acc : myAcc) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }
        return accountIdsToNames;
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact[] myAccountName = [select Id,Account.Name from Contact where Id = :contactId]; 
        String Name;
        for (Contact con : myAccountName) {
            Name = con.Account.Name;
        }
        return Name;
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        Account accWithOpps = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId];
        return accWithOpps;
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        Account myAcc = [select Id,BillingState from Account where Id = :accountId];
        String myBillingState = myAcc.BillingState;
        Contact[] myCon = [Select Id,Name from Contact Where MailingState = :myBillingState];
        if (myCon.size()>0) {
            return myCon;
        } else {
            return null;
        }
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {

        Lead [] myList = [Select Id,Email from Lead where Id IN :leadIds];
        if (myList.size()>0) {
            Set <String> domainList = new Set<String>();
            for (Lead Le : myList) {
                domainList.add('%'+Le.Email.substringAfter('@'));
            }             
        Account[] myAccounts = [select Id,Name,Website from Account where Website LIKE :domainList];
        if (myAccounts.size()>0) {
            return myAccounts;
        } else {
            return new List<Account>();
        }
    } 
     else {
        return new List<Account>();
     }  
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        OpportunityLineItem[] origOpptyLines = [SELECT Id,OpportunityId,Quantity, UnitPrice,PricebookEntryId,TotalPrice FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
        for (Integer i=0 ; i<cloneOppIds.size(); i++) {
            for (OpportunityLineItem oli : origOpptyLines) {
                OpportunityLineItem newOpptyLines = new OpportunityLineItem(OpportunityId =cloneOppIds[i], Quantity = 5, PricebookEntryId = oli.PricebookEntryId, TotalPrice = oli.TotalPrice);
                Insert newOpptyLines;
            }   
        }
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {     
        Opportunity[] myList = [select Name,Account.Name,Owner.Name,accountId,Primary_Contact__c FROM Opportunity where StageName = 'Closed Won'];   
        return myList;
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities

        List<Opportunity> myOpps = SOQL.getOpportunityDetailsForClosedWon();

        Set<Id> accountIds = new Set<Id>(); 
        for (Opportunity op : myOpps) {
            accountIds.add(op.accountId);
        }

        Map<Id, Id> accountToContactMap = new Map<Id, Id>();
        Contact[] myContacts = [SELECT Id,accountId from Contact where accountId = :accountIds];
        for (Contact con : myContacts) {
            accountToContactMap.put(con.accountId, con.Id);
            for (Opportunity opp : myOpps) {
                opp.Primary_Contact__c = accountToContactMap.get(con.accountId);
                update opp;
            }
        }
        }
        
  

        // Create a set of Account Ids from the Opportunities

        // Query the Contacts

        // Loop through each Contact and add the Account Id and Contact to the map
        
        // Loop through each Opportunity

                // Update the Opportunity primary contact from accountToContactMap

        // Update the Opportunities
    
}