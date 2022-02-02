/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/07/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/07/2021  bianca.andrade@moldsoft.com.br        Initial Version
**/
public class CaseHandler implements TriggerHandlerInterface{
	private static final CaseHandler instance = new CaseHandler ();
    public static CaseHandler getInstance () {
        return instance;
    }

    public void beforeUpdate () {
        String valor  = 'beforeUpdate';
        System.debug(valor);
        CaseUtil.hasTranscript((List<Case>) Trigger.new);
        CaseUtil.ChangeOwnerToSustentacao((List<Case>) Trigger.new);
        CaseUtil.SustentacaoAzuitechQueue((List<Case>) Trigger.new,(List<Case>) Trigger.old);
         Map<Id,Case> oldCases = (Map<Id, Case>) Trigger.oldMap;
        system.debug((List<Case>) Trigger.new);
        for(Case c : (List<Case>) Trigger.new){
            c.Subject = c.Reason + '-' + c.Categoria__c + '-' + c.Subcategoria__c;
            system.debug(c.EncaminhadoParaSustentacao__c);
            system.debug(c.Encaminhas_para_Dock__c);
            if(c.EncaminhadoParaSustentacao__c == 'Sim'){
                c.Status = c.StatusSustentacao__c;
            }
            if(c.Encaminhas_para_Dock__c == 'Sim'){
                c.Status = c.Status_Dock__c;
            }
          
        }
       CaseUtil.completeMarco((List<Case>) Trigger.new, (Map<Id, Case>) Trigger.oldMap);
    }

    public void beforeInsert () {
        String valor  = 'beforeInsert';
        System.debug(valor);
        CaseUtil.automationSLA((List<Case>) Trigger.new);
        CaseUtil.checkSustentacao_Azuitech((List<Case>) Trigger.new);
        CaseUtil.SustentacaoAzuitechQueue((List<Case>) Trigger.new);
          for(Case c : (List<Case>) Trigger.new){
            c.Subject = c.Reason + '-' + c.Categoria__c + '-' + c.Subcategoria__c;
          }
    }
    
    public void beforeDelete () { 
        String valor  = 'beforeDelete';
        System.debug(valor);

    }

    public void afterUpdate () { 
         
        String valor  = 'afterUpdate';
        System.debug(valor);
        //CaseUtil.completeMarco((List<Case>) Trigger.new, (Map<Id, Case>) Trigger.oldMap);
         
    }

    public void afterInsert () { 
        String valor  = 'afterInsert';
        CaseUtil.sendEmailSustentacao((List<Case>) Trigger.new);
        System.debug(valor);
    }

    public void afterDelete () { 
        String valor  = 'afterDelete';
        System.debug(valor);
    }
}