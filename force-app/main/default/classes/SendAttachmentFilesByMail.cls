public class SendAttachmentFilesByMail {
    @InvocableMethod
    public static void sendMail(List<Case> cases){
        
       List<User> users = [SELECT Email FROM User WHERE Id IN (SELECT UserOrGroupId FROM GroupMember WHERE Group.DeveloperName = 'Sustentacao')];
		List<string> listEmails= new List<string> ();
        List<EmailSustentacao__mdt> emailMdt= [select id, email__c from EmailSustentacao__mdt where active__c = true];       
        if(emailMdt.size()>0){
            for(EmailSustentacao__mdt e : emailMdt ){
                listEmails.add(e.Email__c);
            }            
        }       
        for(User u : users){
            listEmails.add(u.Email);
        }
        for(Case c : cases){
            string RecordId = c.Id;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            Messaging.Emailfileattachment efa1 = new Messaging.Emailfileattachment();
            List<id> ContentDocumentids = new List<id>();        
            for(contentDocumentLink CDLink : [SELECT LinkedEntityid, ContentDocumentid FROM contentDocumentLink WHERE LinkedEntityid=:RecordID])
            {
                ContentDocumentids.add(CDLink.ContentDocumentid);  
            }
             Blob Data;
            ContentVersion cv;
            if(ContentDocumentids.size()>0){
                
          
            /* GET Data for the image */
               
             cv = [SELECT title,PathOnClient, FileType,
                                 versiondata 
                                 FROM contentversion 
                                 WHERE ContentDocumentId IN :ContentDocumentids  ];           
               Data  = cv.VersionData;
              }
            
            
            
                mail.setSenderDisplayName('BEMOL CASES');
                mail.setSubject('Caso '+ c.CaseNumber +' encaminhado para sustentação');
                mail.setToAddresses(listEmails);
                if(ContentDocumentids.size()>0){
                    efa1.setBody(Data);
                    efa1.setFileName(Cv.Title); 
                    mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1}); 
                }
               
				
              
                mail.setHtmlBody(createHTMLBody(c));
                // This line is throwing the Error 
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

            
        }
    }
    private static string createHTMLBody(Case c){
        string html = 'Prezados,<br><br>'+
            'Caso '+ c.CaseNumber +' encaminhado para sustentação;'+
            '<br>'+
            '<br>'+
            'Numero do caso: '+ c.CaseNumber +' <br>'+
            'Assunto: '+ c.Subject +' <br>'+
            'Descrição: '+ c.Description +'<br>'+
            'Categoria: '+ c.Categoria__c +' <br>'+
            'Subcategoria: '+ c.Subcategoria__c +' <br>'+
            'Sistema operacional: '+ c.Sistema_Operacional__c +' <br>'+
            'Data/Hora do caso: '+ c.CreatedDate +' <br>'+
            'CPF/CNPJ: '+ c.CPFCNPJ__c +' <br>'  ;            
    return html;
	}

    
}