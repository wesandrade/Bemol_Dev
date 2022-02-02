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
public class EmailLiveChatController {
    public Id contactId {
        get{
            if(contactId == null)
                contactId = apexpages.currentpage().getparameters().get('contact');
            return contactId;
        }
        set;
    }
    public Id caseId {
        get{
            if(caseId == null)
                caseId = apexpages.currentpage().getparameters().get('case');
            return caseId;
        }
        set;
    }
    public String conversa {
        get{
            if(conversa == null && this.contactId != null && this.caseId != null){
                try {
                    conversa = [SELECT Body 
                                FROM LiveChatTranscript 
                                WHERE ContactId =: this.contactId
                                AND CaseId =: this.caseId order by CreatedDate desc LIMIT 1].Body;
                    conversa = tranlateConversation(conversa);
                } catch(Exception error) {
                    conversa = 'Nenhuma conversa encontrada.';
                }
            } else{
                conversa = 'Nenhuma conversa encontrada.';
            }
            return conversa;
    	}
        set;
    }
    
    public static String tranlateConversation(String conversa){
        Map<String, String> mapDays = new Map<String, String>();
        mapDays.put('Sunday', 'Domingo');
        mapDays.put('Monday', 'Segunda-feira');
        mapDays.put('Tuesday', 'Terça-feira');
        mapDays.put('Wednesday', 'Quarta-feira');
        mapDays.put('Thursday', 'Quinta-feira');
        mapDays.put('Friday', 'Sexta-feira');
        mapDays.put('Saturday', 'Sábado');
        
        Map<String, String> mapMonth = new Map<String, String>();
        mapMonth.put('January', 'Janeiro');
        mapMonth.put('February', 'Fevereiro');
        mapMonth.put('March', 'Março');
        mapMonth.put('April', 'Abril');
        mapMonth.put('May', 'Maio');
        mapMonth.put('June', 'Junho');
        mapMonth.put('July', 'Julho');
        mapMonth.put('July', 'Agosto');
        mapMonth.put('September', 'Setembro');
        mapMonth.put('October', 'Outubro');
        mapMonth.put('November', 'Novembro');
        mapMonth.put('December', 'Dezembro');
        
        for(String day : mapDays.keySet()){
            if(conversa.contains(day)) conversa = conversa.replace(day, mapDays.get(day));
        }
        
        for(String month : mapMonth.keySet()){
            if(conversa.contains(month)) conversa = conversa.replace(month, mapMonth.get(month));
        }
        
        return conversa;
    }
}