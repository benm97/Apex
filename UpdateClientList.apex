@RestResource(urlMapping='/UpdateClientList/*')
global with sharing class UpdateClientList {
  
  @HttpPost
  global static String doUpdate(String accountName, String clientListName) {
        Account[] clients = [SELECT Id, Name FROM Account WHERE Name = :accountName];
        ClientList__c[] clientLists = [SELECT Name, Description__c, ImageURL__c 
                                    FROM ClientList__c WHERE Name = :clientListName];         //try to find the objects from the params
            if (clients.size() <= 0 || clientLists.size() <= 0){    //returns failed if the params were wrong 
                return 'Failed'; 
            }
        Account client=clients[0];
        ClientList__c clientList=clientLists[0];
         //checks if there is already the same clientlistmember 
        ClientListMember__c[] same =  [SELECT Account__c, ClientList__c
                                    FROM ClientListMember__c WHERE Account__r.Id = :client.Id and ClientList__r.Id = :clientList.Id];
            if (same.size() > 0){  //returns failed if there is
               return 'Failed';
            }
        ClientListMember__c clientListMember = new ClientListMember__c();
        clientListMember.Account__c = client.id;
        clientListMember.ClientList__c = clientList.id;  //update all the fields of the record
        insert clientListMember;
        return 'Succeed:'  + clientListMember.Id;
    }
}