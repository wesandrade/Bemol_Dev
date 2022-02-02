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
trigger CaseTrigger on Case (
    before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
        if (Trigger.isBefore)
            if (Trigger.isUpdate)
                CaseHandler.getInstance().beforeUpdate();
            else if (Trigger.isInsert)
                CaseHandler.getInstance().beforeInsert();
            else
                CaseHandler.getInstance().beforeDelete();
        else
            if (Trigger.isUpdate)
                CaseHandler.getInstance().afterUpdate();
            else if (Trigger.isInsert)
                CaseHandler.getInstance().afterInsert();
            else 
                CaseHandler.getInstance().afterDelete();

}