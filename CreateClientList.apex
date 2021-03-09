@RestResource(urlMapping='/CreateClientList/*')
global with sharing class CreateClientList {
  
  @HttpPost
  global static String doCreate(String name,
        String description, String imageURL) {
            if (name == null || description == null || imageURL == null){ //checks if the user enters all the params
               return 'Failed';                                           // and returns failed if not
            }
        ClientList__c clientlist = new ClientList__c();
        clientlist.Name = name;
        clientlist.Description__c = description;
        clientlist.ImageURL__c = imageURL;       //update all the fields of the record
        insert clientlist;
        return 'Succeed:'  + clientlist.Id;
    }
}