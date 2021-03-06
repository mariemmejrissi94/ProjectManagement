public with sharing class ListProjetController {
    @AuraEnabled
    public static list < Projet__c > fetchProject() {
  list < Projet__c > returnConList = new List < Projet__c > ();
  List < Projet__c > lstCon = [SELECT Name, iconstatus__c,Description_projet__c, date_debut__c, date_fin__c, Etat__c,Ressource__r.Name From Projet__c ORDER BY date_fin__c DESC NULLS LAST LIMIT 50];
      for (Projet__c c: lstCon) {
            returnConList.add(c);
        }
        return returnConList;
    }
    @AuraEnabled
    public static List <Projet__c> loadData(){
        return [SELECT Name, iconstatus__c,Description_projet__c, date_debut__c, date_fin__c, Etat__c,Ressource__r.Name From Projet__c ORDER BY date_fin__c DESC NULLS LAST LIMIT 50];
    }
 @AuraEnabled
    public static List<Projet__c> UpdateRecord(String conid){
        return [SELECT Id,Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c FROM Projet__c WHERE Id =:conid];
    }  
    @AuraEnabled
       public static List<Projet__c> showdetail (String conid){
        return [SELECT Id,Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c FROM Projet__c WHERE Id =:conid];
    }  
    @AuraEnabled
       public static List<Sprint__c> showsprint (String conid){
        return [Select Id, Name FROM Sprint__c where Projet__c=:conid];
    }     
    @AuraEnabled
    public static List < String > deleteRecords(List < String > lstRecordId) {
        List < String > oErrorMsg = new List < String > ();
        List < Projet__c > lstDeleteRec = [select Id from Projet__c where id IN: lstRecordId];

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
        List < Projet__c > lstOfAccount = [SELECT Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c,Ressource__r.Name From Projet__c  where Name LIKE: searchKey LIMIT 50];
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
        
        List < Tache__c > lstCon = [SELECT Name, desc_tache__c, date_debut__c, date_fin__c, Note__c,priorite__c,Etat__c FROM Tache__c ORDER BY date_fin__c ASC NULLS LAST LIMIT 50];
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
    @AuraEnabled
    public static String saveTodoRecord(Projet__c toDoRecord){
        String message;
        Database.saveResult sr = Database.insert(toDoRecord,false);
        if(!sr.isSuccess()){
            for(Database.error err : sr.getErrors()){
                message += err.getMessage();
            }
        }
        return message;
    }
    @AuraEnabled
    public static String saveTodoRecorde(Sprint__c toDoRecord){
          String message;
        system.assert(toDoRecord.date_debut__c.daysBetween(toDoRecord.date_fin__c)>=14);
        system.assert(toDoRecord.date_debut__c.daysBetween(toDoRecord.date_fin__c)<=28);
        if((toDoRecord.date_debut__c.daysBetween(toDoRecord.date_fin__c)>=14) && (toDoRecord.date_debut__c.daysBetween(toDoRecord.date_fin__c)<=28))
            
        {
            try{
                
                Database.saveResult sr = Database.insert(toDoRecord,false);
                
            }catch (DmlException ex) {
                throw new AurahandledException('Error Details : ' + ex.getDmlMessage(0));
            } catch (Exception ex) {
                throw new AurahandledException('Error Details : ' + ex.getMessage());
            }
        }
         return message;
        
    }

    
    @AuraEnabled
    public static Projet__c updateRecordProjet(Id conid,String Naame,String deesc, Date date1, Date date2,String etaat,String responsable) {
        system.debug('Inupdate++ ');
        system.debug('Naame++ '+Naame);
    
        Projet__c c = [Select Name,Description_projet__c,date_debut__c,date_fin__c,Etat__c from Projet__c where Id=:conid];
        c.Name=Naame;
        c.Description_projet__c=deesc;
        c.date_debut__c=date1;
        c.date_fin__c=date2;
        c.Etat__c=etaat;
         c.Ressource__c=responsable;
        system.debug('c Project++ '+c);
        try {
            if(c != null)
                update c;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to Update Projet:'  + e.getMessage());
        }
        return c;
        
    }
    @AuraEnabled 
    public static List<Projet__c> fetchproj(){
        return [SELECT Name, iconstatus__c,Description_projet__c, date_debut__c, date_fin__c, Etat__c,Ressource__r.Name,Ressource__r.Role__c  From Projet__c  ORDER BY date_fin__c  ASC NULLS LAST LIMIT 50];
    }
    @AuraEnabled 
    public static List<Tache__c> fetchprojet(){
        return [SELECT id,Name, iconstatus__c,desc_tache__c, date_debut__c, date_fin__c, Note__c,Etat__c ,Ressource__r.Name,Ressource__r.Role__c From Tache__c  ORDER BY date_fin__c  ASC NULLS LAST LIMIT 50];
    }
    @AuraEnabled 
    public static List<Sprint__c> fetchssprint(){
        return [ SELECT Id,Name,iconstatus__c,description_sprint__c,date_debut__c,date_fin__c,priorite__c,Etat__c From Sprint__c  ORDER BY date_fin__c  ASC NULLS LAST LIMIT 50];
    }
    @AuraEnabled 
    public static List<UserStory__c> fetchsuser(){
        return [ SELECT Id,Name,description_userstory__c,iconstatus__c,date_debut__c,date_fin__c,priorite__c,etat__c  From UserStory__c  ORDER BY date_fin__c  ASC NULLS LAST LIMIT 50];
    }
    @AuraEnabled 
    public static List<SouTache__c> fetchsubtask(){
        return [ SELECT Id,date_debut__c,date_fin__c,desc_soutache__c,iconstatus__c,Etat__c,Name,priorite__c,Ressource__r.Name,Ressource__r.Role__c From SouTache__c  ORDER BY date_fin__c  ASC NULLS LAST LIMIT 50];
    }
    
    //Get Id of projet 
    @AuraEnabled
    public static List <String> getprojet(List < String > lstRecordId){
        // for store Error Messages  
        List < String > oErrorMsg = new List < String > ();
        // Query Records for delete where id in lstRecordId [which is pass from client side controller] 
        List < Projet__c > lstDeleteRec = [SELECT id,Name, Description_projet__c, date_debut__c, date_fin__c, Etat__c From Projet__c where id IN: lstRecordId];
        
        
        return oErrorMsg;
        
    }
    
    
    @AuraEnabled
    public static String saveRecord(Sprint__c toDoRecord){
        String message;
        Database.saveResult sr = Database.insert(toDoRecord,false);
        if(!sr.isSuccess()){
            for(Database.error err : sr.getErrors()){
                message += err.getMessage();
            }
        }
        return message;
    }
    
    
    @AuraEnabled        
    public static List<String> getPickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
    //child parent
    
    @AuraEnabled
    public static List<Projet__c> getAccountRecords() {
        return new List<Projet__c>([Select id,Name from Projet__c LIMIT 100]);
    }
    @AuraEnabled
    public static List<Sprint__c> getContactRecords(string accId) {
        return new List<Sprint__c>([Select id,Name from Sprint__c Where Projet__c =: accId LIMIT 100]);
    }
    @AuraEnabled
    public static List<UserStory__c> getuserRecords(string accId) {
        return new List<UserStory__c>([Select id,Name from UserStory__c Where Sprint__c =: accId LIMIT 100]);
    }
    @AuraEnabled
    public static List<Tache__c> gettacheRecords(string accId) {
        return new List<Tache__c>([Select id,Name from Tache__c Where User_Story__c =: accId LIMIT 100]);
    }
    @AuraEnabled
    public static List<SouTache__c> getsoutacheRecords(string accId) {
        return new List<SouTache__c	>([Select id,Name from SouTache__c	 Where Tache__c =: accId LIMIT 100]);
    }
    
}
