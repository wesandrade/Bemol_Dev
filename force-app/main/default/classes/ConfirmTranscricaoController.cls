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
public class ConfirmTranscricaoController {
    public Id caseId {get;set;}
    public String url {
        get{
            if(url == null && !Test.isRunningTest()){
                url = [SELECT 
                       Url__c 
                       FROM SiteExterno__mdt 
                       WHERE MasterLabel = 'Transcricao do chat'].Url__c;
            	url += '?id=' + this.caseId;
            }
            return url;
        }
        set;
    }
}