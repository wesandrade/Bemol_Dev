/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/01/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/01/2021  bianca.andrade@moldsoft.com.br        Initial Version
**/
trigger AccountTrigger on Account (
    before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
        if (Trigger.isBefore)
            if (Trigger.isUpdate)
                AccountHandler.getInstance().beforeUpdate();
            else if (Trigger.isInsert)
                AccountHandler.getInstance().beforeInsert();
            else
                AccountHandler.getInstance().beforeDelete();
        else
            if (Trigger.isUpdate)
                AccountHandler.getInstance().afterUpdate();
            else if (Trigger.isInsert)
                AccountHandler.getInstance().afterInsert();
            else 
                AccountHandler.getInstance().afterDelete();
}