public class CaseUtil {
    public static void automationSLA(List<Case> newCases){
    	Entitlement direitoPadrao = [SELECT Id FROM Entitlement WHERE Name = 'Direito padrão' LIMIT 1];
        for(Case c : newCases){
            c.EntitlementId = direitoPadrao.Id;
            system.debug('Sustentação >>>' + c.EncaminhadoParaSustentacao__c);
        }
    }
    public static void checkSustentacao_Azuitech(List<Case> newCases){
       
        for(Case c: newCases){
            if(c.Encaminhas_para_Dock__c == 'Sim' && c.EncaminhadoParaSustentacao__c == 'Sim' ){
                c.addError('Não é possível selecionar Sim para Encaminhar para sustenção e ajustar Dock na criação do caso');
            }
        }
    }
    public static void SustentacaoAzuitechQueue(List<Case> newCases,List<Case> oldCases){
        Map<String,Group> mGroups = new Map<String,Group>();
		List<Group> groups = [SELECT DeveloperName,Id FROM Group where type = 'Queue'];
		for(Group g : groups){
    		mGroups.put(g.DeveloperName,g);
		}
		Id userId = userinfo.getUserId();
		User userDetails =[SELECT Id, Name, Email, Profile.Name, UserRole.Name FROM User where Id=:userId ];
        Map<Id,Case> mOldCases = new Map<Id,Case>(oldCases);
        for(Case c: newCases){
            system.debug(mOldCases.get(c.Id).EncaminhadoParaSustentacao__c);
            system.debug(c.EncaminhadoParaSustentacao__c);
            if(mOldCases.get(c.Id).EncaminhadoParaSustentacao__c == 'Não' && c.EncaminhadoParaSustentacao__c == 'Sim'
              && c.Encaminhas_para_Dock__c == 'Não'){
                c.OwnerId = mGroups.get('Sustentacao').Id;
                system.debug('Sustentação');
            }
            if(mOldCases.get(c.Id).Encaminhas_para_Dock__c == 'Não' && c.Encaminhas_para_Dock__c == 'Sim'){
                c.OwnerId = mGroups.get('Zendesk_Dock').Id;
                 system.debug('Dock');
            }
            if(c.Encaminhas_para_Dock__c == 'Não' && c.EncaminhadoParaSustentacao__c == 'Não' && userDetails.UserRole.Name != 'CS'){
                c.OwnerId = mGroups.get('CS').Id;
                system.debug('CS');
            }       
        }
    }
    public static void SustentacaoAzuitechQueue(List<Case> newCases){
        Map<String,Group> mGroups = new Map<String,Group>();
		List<Group> groups = [SELECT DeveloperName,Id FROM Group where type = 'Queue'];
		for(Group g : groups){
    		mGroups.put(g.DeveloperName,g);
		}
		Id userId = userinfo.getUserId();
        User userDetails =[SELECT Id, Name, Email, Profile.Name, UserRole.Name FROM User where Id=:userId ];
        for(Case c: newCases){
            system.debug('Cheguei 1');
            if(c.EncaminhadoParaSustentacao__c == 'Sim'){
                c.OwnerId = mGroups.get('Sustentacao').Id;
                c.Status = c.StatusSustentacao__c;
                            system.debug('Cheguei 2');
            }
            if(c.Encaminhas_para_Dock__c == 'Sim'){
                c.OwnerId = mGroups.get('Zendesk_Dock').Id;
                c.Status = c.Status_Dock__c;
                            system.debug('Cheguei 3');
            }
            if(c.Encaminhas_para_Dock__c == 'Não' && c.EncaminhadoParaSustentacao__c == 'Não' && userDetails.UserRole.Name != 'CS'){
                c.OwnerId = mGroups.get('CS').Id;
                system.debug('CS');
            }       
        }
    }
    public static void ChangeOwnerToSustentacao(List<Case> newCases){
        /*Group g = [SELECT Id, Type, OwnerId, Name FROM Group where Name = 'Sustentação'];
        for(Case c: newCases){
            if(c.EncaminhadoParaSustentacao__c == 'Sim'){
                c.OwnerId = g.Id;
            }
        }*/
    }
    public static void sendEmailSustentacao(List<Case> newCases){
        List<Case> casesMail = new List<Case>();
        for(Case c: newCases){
            if(c.EncaminhadoParaSustentacao__c == 'Sim'){
                casesMail.add(c);
            }
        }
        if(casesMail.size()>0){
            //SendAttachmentFilesByMail.sendMail(newCases);
        }
    }
    public static void completeMarco(List<Case> newCases, Map<Id,Case> oldCases){
        Set<Id> caseIds = new Set<Id>();
        for(Case c : newCases){
          
                if(c.Status != 'Sustentação' && oldCases.get(c.Id).Status =='Sustentação'){
					caseIds.add(c.Id);
            }
             if(c.Status != 'Customer Success' && oldCases.get(c.Id).Status =='Customer Success'){
                caseIds.add(c.Id);
            }
        }
        List<CaseMilestone> cmList = [SELECT Id, CompletionDate, CaseId 
                                      FROM CaseMilestone 
                                      WHERE IsCompleted = false 
                                      AND CaseId IN: caseIds];

        List<CaseMilestone> cmListToUpdated = new List<CaseMilestone>();
        
        if(cmList.size() > 0){ 
            for(CaseMilestone cm : cmList){
                cm.CompletionDate = Datetime.now();
                cmListToUpdated.add(cm);
            }
            update cmListToUpdated;
        } else {
            System.debug('CaseUtil.completeMarco - É um teste!');
        }
        
    }
    public static void hasTranscript(List<Case> newCases){
        Map<Id, Id> mapClosedCaseIds = new Map<Id, Id>();
        List<String> keyList = new List<String>();
        
        for(Case caso : newCases){
            if(caso.Status == 'Resolvido'){
                mapClosedCaseIds.put(caso.Id, caso.ContactId);
            }
            
        }
        
        List<LiveChatTranscript> lctList = [SELECT Id, CaseId, ContactId
                                            FROM LiveChatTranscript 
                                            WHERE CaseId IN: mapClosedCaseIds.keySet() 
                                            AND ContactId IN: mapClosedCaseIds.values()];
        
        for(LiveChatTranscript lct : lctList){
			keyList.add(lct.CaseId + '-' + lct.ContactId);
        }
        
        for(Case caso : newCases){
            if(caso.Status == 'Resolvido'){
                String key = caso.Id + '-' + caso.ContactId;
                if(keyList.contains(key)) 
                    caso.TemTranscricao__c = true;
                else
                    caso.TemTranscricao__c = false;
            }
        }
    }
}