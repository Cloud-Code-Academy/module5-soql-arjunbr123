// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);


SELECT Id, Primary_Contact_c FROM Opportunity


    public static List<Lead> GetAllLeads () {

 system.debug(Database.query('SELECT Id,LastName,Company,Phone,Email FROM Lead LIMIT 1'));
        return Database.query('SELECT Id,LastName,Company,Phone,Email FROM Lead LIMIT 1');
       
    }


      Contact[] myContacts = [SELECT Name from Contact WHERE FirstName = 'John'];
        //if (myContacts.size()>0) {
          system.debug(myContacts);
        //}
        //else {
        //}


        SELECT Id,LastName,Company,Phone,Email,LeadSource,Title FROM Lead WHERE (LeadSource = 'new' OR Title = 'new')

        SELECT SUM(Amount) from Opportunity where StageName = 'Closed Won';

          List <AggregateResult> totalRevenue = [SELECT SUM(Amount) totalRev from Opportunity where StageName = 'Closed Won'];
        if (totalRevenue.size()>0) {
           for (AggregateResult ar : totalRevenue) {
            system.debug(ar.get('totalRev'));
            }
        }


SELECT Id,CreatedDate,Status FROM Case WHERE Status = 'Open' Order by CreatedDate LIMIT 10 OFFSET 5


select id,Account.Name,AccountId from Contact where Id = '003Dn000006hEjaIAE'

SELECT NAME,Opportunity__c FROM Account where Id = '001Dn00000AZVDzIAP'

select Name,account.Name from Opportunity where AccountId = '001Dn00000AZVDzIAP'

 Opportunity[] myList = [select Id,Name,Account.Name,(select name from Account.Name) from Opportunity where AccountId = '001Dn00000AZVDzIAP'];
 System.debug(myList);


Opportunity[] myList = [SELECT Name,Account.Name FROM Opportunity where AccountId = '001Dn00000AZVDzIAP'];
 System.debug(myList);

 Opportunity:{Name=Edge Emergency Generator, AccountId=001Dn00000AZVDzIAP, Id=006Dn000004uoWpIAI}



 Opportunity[] myList = [SELECT Id,Name,Account.Name,Account.Id FROM Opportunity where AccountId = '001Dn00000AZVDzIAP'];
 System.debug(myList);


  Account[] myList = [SELECT Id,Name,(select Id,Name from Opportunities) FROM Opportunity where AccountId = '001Dn00000AZVDzIAP'];
 System.debug(myList);

  Account accWithOpps = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = '001Dn00000AZVDzIAP'];
   System.debug(accWithOpps);
 