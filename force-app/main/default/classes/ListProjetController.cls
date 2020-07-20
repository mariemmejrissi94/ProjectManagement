public with sharing class ListProjetController {
    @AuraEnabled
    public static list < Projet__c > fetchContact() {
     list < Projet__c > returnConList = new List < Projet__c > ();
    
     List < Projet__c > lstCon = [SELECT Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c From Projet__c ORDER BY date_fin__c DESC NULLS LAST LIMIT 50];
     // play for loop on lstCon and add each Projet__c to returnConList List.
     for (Projet__c c: lstCon) {
      returnConList.add(c);
     }
    // return the List of Projet__cs
     return returnConList;
    }
    @AuraEnabled
    public static List <Projet__c> loadData(){
        return [SELECT Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c From Projet__c ORDER BY date_fin__c DESC NULLS LAST LIMIT 50];
    }
  
    @AuraEnabled
    public static List < String > deleteRecords(List < String > lstRecordId) {
     // for store Error Messages  
     List < String > oErrorMsg = new List < String > ();
     // Query Records for delete where id in lstRecordId [which is pass from client side controller] 
     List < Projet__c > lstDeleteRec = [select Id from Projet__c where id IN: lstRecordId];
     
     // delte Projet__c list with Database.DeleteResult[] database class.
     // It deletes some queried Projet__cs using <samp class="codeph apex_code">Database.<span class="statement">delete</span></samp> 
     // with a false second parameter to allow partial processing of records on failure.
     // Next, it iterates through the results to determine whether the operation was successful or not
     // for each record. and check if delete Projet__c successful so print msg on debug, 
     // else add error message to oErrorMsg List and return the list  
     Database.DeleteResult[] DR_Dels = Database.delete(lstDeleteRec, false);
     // Iterate through each returned result
     for (Database.DeleteResult dr: DR_Dels) {
      if (dr.isSuccess()) {
         system.debug('successful delete Projet__c');
        // Operation was successful
      } else {
       // Operation failed, so get all errors   
       oErrorMsg.add('');
       for (Database.Error err: dr.getErrors()) {
        // add Error message to oErrorMsg list and return the list
        oErrorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
       }
      }
     }
     return oErrorMsg;
    
    }
  
    
  // method for update records after inline editing  
    @AuraEnabled
    public static List < Projet__c > saveAccount(List<Projet__c> lstAccount) {
        update lstAccount;
        return lstAccount;
    }
    
  // method for fetch picklist values dynamic  
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    @AuraEnabled
 public static List < Projet__c > fetchAccount(String searchKeyWord) {
  String searchKey = searchKeyWord + '%';
  List < Projet__c > returnList = new List < Projet__c > ();
  List < Projet__c > lstOfAccount = [SELECT Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c From Projet__c  where Name LIKE: searchKey LIMIT 50];
  for (Projet__c acc: lstOfAccount) {
   returnList.add(acc);
  }
  return returnList;
      }
      @AuraEnabled
    public static List<Projet__c> getsprint(){
        List<Projet__c> contactList = new List<Projet__c>();
        for(Projet__c oCon : [SELECT  Name From Projet__c LIMIT 10]){
           contactList.add(oCon); 
        }
        return contactList;
    }
    @AuraEnabled
    public static list < Sprint__c > fetchsprint() {
     list < Sprint__c > returnConList = new List < Sprint__c > ();
    
     List < Sprint__c > lstCon = [SELECT Name, Description_Sprint__c, date_debut__c, date_fin__c,priorite__c, Etat__c From Sprint__c ORDER BY date_fin__c ASC NULLS LAST LIMIT 50];
     // play for loop on lstCon and add each UserStory__c to returnConList List.
     for (Sprint__c c: lstCon) {
      returnConList.add(c);
     }
    // return the List of UserStory__cs
     return returnConList;
    }
    @AuraEnabled
    public static list < UserStory__c > fetchuser() {
     list < UserStory__c > returnConList = new List < UserStory__c > ();
    
     List < UserStory__c > lstCon = [SELECT Name, Description_UserStory__c, date_debut__c, date_fin__c,priorite__c, etat__c From UserStory__c ORDER BY date_fin__c ASC NULLS LAST LIMIT 50];
     // play for loop on lstCon and add each UserStory__c to returnConList List.
     for (UserStory__c c: lstCon) {
      returnConList.add(c);
     }
    // return the List of UserStory__cs
     return returnConList;
    }
    @AuraEnabled
    public static list < Tache__c > fetchtache() {
     list < Tache__c > returnConList = new List < Tache__c > ();
    
     List < Tache__c > lstCon = [SELECT Name, desc_tache__c, date_debut__c, date_fin__c, Note__c,priorite__c,Etat__c,temp_estime__c FROM Tache__c ORDER BY date_fin__c ASC NULLS LAST LIMIT 50];
     // play for loop on lstCon and add each UserStory__c to returnConList List.
     for (Tache__c c: lstCon) {
      returnConList.add(c);
     }
    // return the List of UserStory__cs
     return returnConList;
    }
    @AuraEnabled
    public static list < SouTache__c > fetchsoutache() {
     list < SouTache__c > returnConList = new List < SouTache__c > ();
    
     List < SouTache__c > lstCon = [SELECT Name, desc_soutache__c, date_debut__c, date_fin__c, Note__c,priorite__c,Etat__c FROM SouTache__c ORDER BY date_fin__c ASC NULLS LAST LIMIT 50];
     // play for loop on lstCon and add each UserStory__c to returnConList List.
     for (SouTache__c c: lstCon) {
      returnConList.add(c);
     }
    // return the List of UserStory__cs
     return returnConList;
    }
    //Parent
      //@AuraEnabled
    //public static string getprojet(){
      //for(Projet__c u: [select Name(select Name from Sprint__c) from Projet__c])
      //{   
          //for(Sprint__c c:u.Sprint__c)
               //System.debug('Projet Name:'+u.Name+'   sprint Name:'+c.Name);
      //}
    //}
  
    //@AuraEnabled
   //public static void getsprint(){
      //For(Sprint__c c:[select Name,Projet__c.Name,Projet__c from Sprint__c])
//{
  //system.debug('sprint Name:'+c.Name+'     Projet Name:'+c.Projet__c.Name);
//}
    //}
  }
   
  
          
    