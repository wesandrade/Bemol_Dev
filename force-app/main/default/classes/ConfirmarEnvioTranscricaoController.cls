/**
 * @File Name          : 
 * @Description        :
 * @Author             : carlos.davi@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : carlos.davi@moldsoft.com.br
 * @Last Modified On   : 16/09/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    16/09/2021  carlos.davi@moldsoft.com.br         Initial Version
**/
public class ConfirmarEnvioTranscricaoController {
    public final String MOSTRAR_PERGUNTA = 'mostrarPergunta';
    public final String NAO_MOSTRAR_PERGUNTA = 'naoMostrarPergunta';
    public final String INVALID_ID = 'invalidId';
    
    public class Result {
        public String status {get;set;}
        public String message {get;set;}
    }
    
    public Id caseId {
        get{
            if(caseId == null){
                try {
                    caseId = apexpages.currentpage().getparameters().get('id');  
                } catch(Exception erro){
                    caseId = null;
                }
            }
            return caseId;
        }
        set;
    }
    
    public Case caso {
        get{
            if(caso == null)
                try {
                	caso = [SELECT Id, RespondeuVFTranscricao__c, TemTranscricao__c, Status FROM Case WHERE Id =: this.caseId];
                } catch(Exception erro){
                    caseId = null;
                }
            return caso;
        }
        set;
    }
    
    public String page {get;set;}
    
    public ConfirmarEnvioTranscricaoController(){
        
    }
    
    public void checkCase(){
        if(this.caseId == null)
            this.page = INVALID_ID;
        else if(!this.caso.TemTranscricao__c)
            this.page = INVALID_ID;
        else if(!this.caso.RespondeuVFTranscricao__c)
            this.page = MOSTRAR_PERGUNTA;
        else
            this.page = NAO_MOSTRAR_PERGUNTA;
    }
    
    @RemoteAction
    public static Result enviarConversa(Boolean response, Id caseId){
        Savepoint sp = Database.setSavepoint();
        Result result = new Result();
        try {
            Case caso = [SELECT Id, ContactEmail, RespondeuVFTranscricao__c, ContactId FROM Case WHERE Id =: caseId];
            caso.RespondeuVFTranscricao__c = true;
            if(response){
                PageReference page = new PageReference('/apex/pageEmailLiveChat');
                page.getParameters().put('case', caso.Id);
                page.getParameters().put('contact', caso.ContactId);
                String pageString = page.getContent().toString();
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setHtmlBody(pageString);
                email.setSubject('Conversa com o agente');
                email.setToAddresses(new List<String>{caso.ContactEmail});
                Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            }
            update caso;
            result.status = 'success';
        } catch (Exception erro) {
            System.debug('Error >>> ' + erro);
            Database.rollback( sp );
            result.status = 'error';
            result.message = erro.getMessage();
        }
        return result;
    }
}